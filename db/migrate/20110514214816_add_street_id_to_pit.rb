class AddStreetIdToPit < ActiveRecord::Migration
  def self.up
    add_column :pits, :street_id, :integer
  end

  def self.down
    remove_column :pits, :street_id
  end
end
