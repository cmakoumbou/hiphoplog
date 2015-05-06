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
	validates :external_url, presence: true

	rails_admin do
    list do
      filters [:artist]
      field :artist
      field :name
    end
    update do
      field :name
    end
  end
end