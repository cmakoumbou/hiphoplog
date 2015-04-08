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
#

class Album < ActiveRecord::Base
	include PgSearch
  multisearchable :against => :name

	belongs_to :channel
	belongs_to :artist

	validates :name, presence: true
	validates :key, presence: true
	validates :published_at, presence: true
	validates :channel_id, presence: true
	validates :artist_id, presence: true
	validates :external_image, presence: true
end
