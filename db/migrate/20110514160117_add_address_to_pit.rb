class AddAddressToPit < ActiveRecord::Migration
  def self.up
    add_column :pits, :address, :string
  end

  def self.down
    remove_column :pits, :address
  end
end
