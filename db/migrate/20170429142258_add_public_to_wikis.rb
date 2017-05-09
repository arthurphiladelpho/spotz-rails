class AddPublicToWikis < ActiveRecord::Migration
  def change
  	add_column :wikis, :public, :boolean, default: false
  end
end
