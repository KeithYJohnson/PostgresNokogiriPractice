class AddConfirmableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :confirmed_at, :datetime
  end
end
