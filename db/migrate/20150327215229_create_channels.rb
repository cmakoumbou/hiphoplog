class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :url
      t.integer :count

      t.timestamps null: false
    end
  end
end
