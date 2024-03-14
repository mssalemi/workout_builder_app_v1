# typed: false
class AddBodyPartMainToEx < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :body_part_main, :string, null: false
  end
end
