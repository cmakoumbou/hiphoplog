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

require 'test_helper'

class SongTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
