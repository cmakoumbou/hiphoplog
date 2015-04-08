class AddChannelRefToSongs < ActiveRecord::Migration
  def change
    add_reference :songs, :channel, index: true, foreign_key: true
  end
end
