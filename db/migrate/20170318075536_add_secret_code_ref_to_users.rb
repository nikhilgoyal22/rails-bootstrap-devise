class AddSecretCodeRefToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :secret_code, foreign_key: true
  end
end
