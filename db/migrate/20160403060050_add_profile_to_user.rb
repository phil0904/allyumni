class AddProfileToUser < ActiveRecord::Migration
  def self.up
    add_column :profiles, :user_id, :integer
    add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"
  end
  def self.down
  	remove_column :profiles, :user_id
  end
end
