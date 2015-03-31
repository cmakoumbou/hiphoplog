class AddArtistRefToChannels < ActiveRecord::Migration
  def change
    add_reference :channels, :artist, index: true, foreign_key: true
  end
end
