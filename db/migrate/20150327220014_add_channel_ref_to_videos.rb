class AddChannelRefToVideos < ActiveRecord::Migration
  def change
    add_reference :videos, :channel, index: true, foreign_key: true
  end
end
