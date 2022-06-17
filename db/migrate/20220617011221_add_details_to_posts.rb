class AddDetailsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :tag_name, :integer
  end
end
