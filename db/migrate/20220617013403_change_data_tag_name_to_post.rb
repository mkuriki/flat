class ChangeDataTagNameToPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :tag_name, :string
  end
end
