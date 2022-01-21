class CreateFreedays < ActiveRecord::Migration[6.0]
  def change
    create_table :freedays do |t|
      t.integer :reason
      t.integer :status
      t.date :start_date
      t.date :end_date
      t.integer :user_id, null: false, foreign_key: true
      t.integer :accepted_by_id, foreign_key: true
      t.integer :rejected_by_id, foreign_key: true

      t.timestamps
    end
  end
end
