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
#

class Channel < ActiveRecord::Base
	SOUNDCLOUD_CLIENT_ID = "c26a11a448231c63650b5319453f2285"
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
		elsif self.url.include? "soundcloud"
			client = Soundcloud.new(:client_id => SOUNDCLOUD_CLIENT_ID)
			channel = client.get('/resolve', url: self.url)
			self.count = channel.track_count
		elsif self.url.include? "spotify"
			spotify_artist_id = self.url.match(/artist\/(\w*)/)[1]
			channel = RSpotify::Artist.find(spotify_artist_id)
			self.count = channel.albums(album_type: 'album', limit: 50, country: 'US').count
		end
	end

	def store_channel_video
		channel = Yt::Channel.new url: self.url
		channel_count = channel.videos.count
		if channel_count > self.count
			number_of_videos = channel_count - self.count
			videos = channel.videos.first(number_of_videos)
			videos.each do |v|
				Video.create(name: v.title, key: v.id, published_at: v.published_at, channel_id: self.id, artist_id: self.artist_id)
			end
			self.count = channel_count
		end
	end

	def store_channel_song
		client = Soundcloud.new(:client_id => SOUNDCLOUD_CLIENT_ID)
		channel = client.get('/resolve', url: self.url)
		channel_count = channel.track_count
		if channel_count > self.count
			number_of_songs = channel_count - self.count
			songs = client.get("/users/#{channel.id}/tracks").first(number_of_songs)
			songs.each do |s|
				Song.create(name: s.title, key: s.id, published_at: s.created_at, channel_id: self.id, artist_id: self.artist_id, 
					external_url: s.permalink_url, external_image: s.artwork_url)
			end
			self.count = channel_count
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
				Album.create(name: a.name, key: a.id, published_at: a.release_date, channel_id: self.id, artist_id: self.artist_id,
					external_image: a.images.first["url"])
			end
			self.count = channel_count
		end
	end
end