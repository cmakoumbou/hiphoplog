class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :key
      t.datetime :published_at
      t.references :channel, index: true, foreign_key: true
      t.references :artist, index: true, foreign_key: true
      t.string :external_image

      t.timestamps null: false
    end
  end
end
