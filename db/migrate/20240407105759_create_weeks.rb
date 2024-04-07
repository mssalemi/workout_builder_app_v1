class CreateWeeks < ActiveRecord::Migration[7.1]
  def change
    create_table :weeks do |t|
      t.references :workout_program, null: false, foreign_key: true

      t.timestamps
    end
  end
end
