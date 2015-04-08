class AddPublishedAtToSongs < ActiveRecord::Migration
  def change
  	add_column :songs, :published_at, :datetime
  end
end
