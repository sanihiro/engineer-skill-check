class ChangeToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :news_posting_auth, :boolean, null: false, default: false
    rename_column :employees, :email, :e_mail
  end
end
