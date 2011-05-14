class AddStreetIndexToPid < ActiveRecord::Migration
  def self.up
    add_index :pits, :street_id
  end

  def self.down
    remove_index :pits, :street_id
  end
end
