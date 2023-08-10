class AddUserBookingModel < ActiveRecord::Migration[6.0]
  def change
    create_table :user_bookings do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :book, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :user_bookings, %i[user_id book_id], unique: true, name: 'index_on_book_id_and_user_id'
  end
end
