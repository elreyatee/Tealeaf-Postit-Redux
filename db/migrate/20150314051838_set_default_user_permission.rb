class SetDefaultUserPermission < ActiveRecord::Migration
  def change
    change_column :users, :permission, :string, default: "user"
  end
end
