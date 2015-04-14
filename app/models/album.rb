# == Schema Information
#
# Table name: albums
#
#  id             :integer          not null, primary key
#  name           :string
#  key            :string
#  published_at   :datetime
#  channel_id     :integer
#  artist_id      :integer
#  external_image :string
#  explicit       :boolean
#

class Album < ActiveRecord::Base
	include PgSearch
  multisearchable :against => [:name, :artist_name]

	belongs_to :channel
	belongs_to :artist

	def artist_name
		artist.name
	end

	validates :name, presence: true
	validates :key, presence: true
	validates :published_at, presence: true
	validates :channel_id, presence: true
	validates :artist_id, presence: true
	validates :external_image, presence: true
end
