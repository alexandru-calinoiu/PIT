class CreatePits < ActiveRecord::Migration
  def self.up
    create_table :pits do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end

  def self.down
    drop_table :pits
  end
end
