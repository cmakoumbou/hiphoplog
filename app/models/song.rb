# == Schema Information
#
# Table name: songs
#
#  id             :integer          not null, primary key
#  name           :string
#  key            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  channel_id     :integer
#  published_at   :datetime
#  artist_id      :integer
#  external_url   :string
#  external_image :string
#

class Song < ActiveRecord::Base
	include PgSearch
  multisearchable :against => :name

	belongs_to :channel
	belongs_to :artist

	validates :name, presence: true
	validates :key, presence: true
	validates :published_at, presence: true
	validates :channel_id, presence: true
	validates :artist_id, presence: true
	validates :external_url, presence: true
end