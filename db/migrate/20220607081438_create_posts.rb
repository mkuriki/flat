class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string "title"
      t.text "body"
      t.integer "user_id"
      t.integer "group_id"
      t.integer "post_image_id"
      t.timestamps
    end
  end
end
