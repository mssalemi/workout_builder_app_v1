class AddOrderToWeeks < ActiveRecord::Migration[7.1]
  def change
    add_column :weeks, :order, :integer
  end
end
