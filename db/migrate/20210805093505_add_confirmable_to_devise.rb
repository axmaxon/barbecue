class AddConfirmableToDevise < ActiveRecord::Migration[6.1]
  def self.up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    # add_column :users, :unconfirmed_email, :string # Only if using reconfirmable

    add_index :users, :confirmation_token, unique: true

    # Существующие учетные записи должны быть в состоянии войти в систему
    User.all.update_all confirmed_at: Time.now
  end

  def self.down
    remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :users, :unconfirmed_email # Only if using reconfirmable
  end
end
