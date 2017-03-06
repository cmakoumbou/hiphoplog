# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  url        :string
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer
#  multi      :boolean
#  provider   :string
#

class Channel < ActiveRecord::Base
	SOUNDCLOUD_CLIENT_ID = ENV['SOUNDCLOUD_CLIENT_ID']
	belongs_to :artist
	has_many :videos, dependent: :destroy
	has_many :songs, dependent: :destroy
	has_many :albums, dependent: :destroy

	validates :url, presence: true
	validates :artist_id, presence: true

	after_validation :store_channel_info, :if => :url_provided?

	def url_provided?
		new_record? && self.url.present? || self.url_changed? && self.url.present?
	end

	def store_channel_info
		if self.url.include? "youtube"
			channel = Yt::Channel.new url: self.url
			self.count = channel.videos.count
			self.provider = "youtube"
		elsif self.url.include? "soundcloud"
			client = Soundcloud.new(:client_id => SOUNDCLOUD_CLIENT_ID)
			channel = client.get('/resolve', url: self.url)
			self.count = channel.track_count
			self.provider = "soundcloud"
		elsif self.url.include? "spotify"
			spotify_artist_id = self.url.match(/artist\/(\w*)/)[1]
			channel = RSpotify::Artist.find(spotify_artist_id)
			self.count = channel.albums(album_type: 'album', limit: 50, country: 'US').count
			self.provider = "spotify"
		end
	end

	def store_channel_video
		channel = Yt::Channel.new url: self.url
		channel_count = channel.videos.count
		if channel_count > self.count
			number_of_videos = channel_count - self.count
			videos = channel.videos.first(number_of_videos)
			if self.multi == true
				videos.each do |v|
					if v.title.downcase.include? self.artist.name.downcase
						Video.create(name: v.title, key: v.id, published_at: v.published_at, channel_id: self.id, artist_id: self.artist_id)
					end
				end
			else
				videos.each do |v|
					Video.create(name: v.title, key: v.id, published_at: v.published_at, channel_id: self.id, artist_id: self.artist_id)
				end
			end
			self.update(count: channel_count)
		elsif self.count > channel_count
			self.update(count: channel_count)
		end
	end

	def store_channel_song(client)
		# client = Soundcloud.new(:client_id => SOUNDCLOUD_CLIENT_ID)
		channel = client.get('/resolve', url: self.url)
		channel_count = channel.track_count
		if channel_count > self.count
			number_of_songs = channel_count - self.count
			songs = client.get("/users/#{channel.id}/tracks").first(number_of_songs)
		  if self.multi == true
		  	songs.each do |s|
		  		if s.title.downcase.include? self.artist.name.downcase
		  			Song.create(name: s.title, key: s.id, published_at: s.created_at, channel_id: self.id, artist_id: self.artist_id,
							external_url: s.permalink_url, external_image: s.artwork_url)
		  		end
		  	end
		  else
				songs.each do |s|
					Song.create(name: s.title, key: s.id, published_at: s.created_at, channel_id: self.id, artist_id: self.artist_id,
						external_url: s.permalink_url, external_image: s.artwork_url)
				end
			end
			self.update(count: channel_count)
		elsif self.count > channel_count
			self.update(count: channel_count)
		end
	end

	def store_channel_album
		spotify_artist_id = self.url.match(/artist\/(\w*)/)[1]
		channel = RSpotify::Artist.find(spotify_artist_id)
		channel_count = channel.albums(album_type: 'album', limit: 50, country: 'US').count
		if channel_count > self.count
			number_of_albums = channel_count - self.count
			albums = channel.albums(album_type: 'album', limit: 50, country: 'US').first(number_of_albums)
			albums.each do |a|
				tracks = a.tracks(limit: 50)
				explicit = tracks.any? {|t| t.explicit == true}
				if explicit == true
					Album.create(name: a.name, key: a.id, published_at: a.release_date, channel_id: self.id, artist_id: self.artist_id,
						external_image: a.images.first["url"], explicit: true)
				elsif explicit == false
					Album.create(name: a.name, key: a.id, published_at: a.release_date, channel_id: self.id, artist_id: self.artist_id,
						external_image: a.images.first["url"], explicit: false)
				end
			end
			self.update(count: channel_count)
		elsif self.count > channel_count
			self.update(count: channel_count)
		end
	end

	def self.process_videos
		Channel.where(provider: "youtube").each do |chan|
			chan.store_channel_video
		end
	end

	def self.process_songs
		client = Soundcloud.new(:client_id => SOUNDCLOUD_CLIENT_ID)
		Channel.where(provider: "soundcloud").each do |chan|
			chan.store_channel_song(client)
		end
	end

	def self.process_albums
		Channel.where(provider: "spotify").each do |chan|
			chan.store_channel_album
		end
	end

  rails_admin do
    list do
      filters [:artist]
      field :artist
      field :url
      field :multi
      field :count
    end
    create do
      field :artist
      field :url
      field :multi
    end
    update do
      field :artist
      field :url
      field :multi
      field :count
      field :provider
    end
    modal do
      field :artist
      field :url
      field :multi
    end
  end
end
