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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  explicit       :boolean
#

class Album < ActiveRecord::Base
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

	rails_admin do
    list do
      filters [:artist]
      field :artist
      field :name
      field :explicit
    end
    update do
      field :name
    end
  end
end
