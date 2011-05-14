class AddUserIdToPits < ActiveRecord::Migration
  def self.up
    add_column 'pits', 'user_id', :integer
  end

  def self.down
  end
end
