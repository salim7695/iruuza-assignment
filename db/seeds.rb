AdminUser.create(email: 'admin@test.com', password: 'admintest')

author = User.create(email: 'author@gmail.com', name: 'Harry Winks')
user1 = User.create(email: 'berry@gmail.com', name: 'Richard Berry')
user2 = User.create(email: 'simmons@gmail.com', name: 'Phill Simmons')

book1 = Book.create(title: 'Dangerous Paths', description: 'It is good', author_id: author.id)
book2 = Book.create(title: 'Himalya Hills', description: 'It is great', author_id: author.id)

UserBooking.create(user_id: user1.id, book_id: book1.id)
UserBooking.create(user_id: user2.id, book_id: book2.id)
