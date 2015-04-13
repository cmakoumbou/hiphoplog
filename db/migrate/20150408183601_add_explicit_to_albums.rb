class AddExplicitToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :explicit, :boolean
  end
end
