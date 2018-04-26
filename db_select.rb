require 'sqlite3'
db = SQLite3::Database.new 'db/users.db'
p db.execute('SELECT * FROM users')

p db.execute('SELECT * FROM comments')

p db.execute('SELECT * FROM upload_images')