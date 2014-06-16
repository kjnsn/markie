class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
