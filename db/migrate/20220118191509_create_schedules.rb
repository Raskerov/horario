class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :name
      t.string :start_hour
      t.string :end_hour
      t.string :weekdays, array: true, default: []
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
