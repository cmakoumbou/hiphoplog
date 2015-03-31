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
  include PgSearch
  multisearchable :against => :name

	has_many :channels, dependent: :destroy
	has_many :videos

	validates :name, presence: true
end
