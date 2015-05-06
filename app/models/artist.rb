# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artist < ActiveRecord::Base
	has_many :channels, dependent: :destroy
	has_many :videos
	has_many :songs
	has_many :albums

	validates :name, presence: true

	rails_admin do
    list do
      field :name
    end
    create do
      field :name
    end
    update do
      field :name
    end
    modal do
      field :name
    end
  end
end
