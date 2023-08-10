class AddBookModel < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.references :author, index: true, foreign_key: { to_table: :users }, null: false

      t.timestamps null: false
    end

    add_index :books, %i[title description], name: 'index_on_book_title_and_description', type: :fulltext
    add_index :books, :title, name: 'index_on_book_title', type: :fulltext
    add_index :books, :description, name: 'index_on_book_description', type: :fulltext
  end
end
