class SimplifyColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :content
    rename_column :cards, :title, :text
  end
end
