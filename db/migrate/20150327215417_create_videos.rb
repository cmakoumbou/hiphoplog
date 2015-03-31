class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :key

      t.timestamps null: false
    end
  end
end
