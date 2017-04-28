class AddRoleToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :role, :integer
  end
end
