class AddMultiToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :multi, :boolean
  end
end
