class ChangeImageFieldToEmoji < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :image_url
    add_column :cards, :emoji, :string
  end
end
