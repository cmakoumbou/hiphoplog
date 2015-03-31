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

require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
