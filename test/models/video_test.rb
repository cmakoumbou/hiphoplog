# == Schema Information
#
# Table name: videos
#
#  id           :integer          not null, primary key
#  name         :string
#  key          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  channel_id   :integer
#  published_at :datetime
#  artist_id    :integer
#

require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
