class CreateUsersAndWikis < ActiveRecord::Migration
  def change
    create_table :wiki_collaborators do |t|
      t.references :wiki, index: true
      t.references :user, index: true
      t.timestamps
    end
    add_index :wiki_collaborators, :id, unique: true
  end
end
