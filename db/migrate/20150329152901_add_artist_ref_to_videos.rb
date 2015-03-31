class AddArtistRefToVideos < ActiveRecord::Migration
  def change
    add_reference :videos, :artist, index: true, foreign_key: true
  end
end
