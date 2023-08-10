class AddUserModel < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :users, :name, name: 'index_on_user_name', type: :fulltext
    add_index :users, :email, unique: true, name: 'index_on_user_email'
  end
end
