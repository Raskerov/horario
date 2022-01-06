class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :text, null: false
      t.integer :sender_id, null: false, foreign_key: true
      t.integer :receiver_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
