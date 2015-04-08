class AddExternalLinksToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :external_url, :string
    add_column :songs, :external_image, :string
  end
end
