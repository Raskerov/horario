class AddCompanyIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :company_id, :integer
    drop_table :company_users
  end
end
