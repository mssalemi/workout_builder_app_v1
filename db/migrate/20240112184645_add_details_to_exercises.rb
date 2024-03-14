# typed: false
class AddDetailsToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :user_id, :integer, default: nil, null: true
    add_column :exercises, :category, :string, default: "Chest", null: false
    add_column :exercises, :body_part_accessory, :jsonb, default: nil, null: true
  end
end