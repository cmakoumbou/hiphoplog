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
	belongs_to :artist
	has_many :videos, dependent: :destroy

	validates :url, presence: true
	validates :artist_id, presence: true

	after_validation :store_channel_info, :if => :url_provided?

	def url_provided?
		new_record? && self.url.present? || self.url_changed? && self.url.present?
	end

	def store_channel_info
		channel = Yt::Channel.new url: self.url
		self.count = channel.videos.count
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
end