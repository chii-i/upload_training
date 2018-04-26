require 'sqlite3'
db = SQLite3::Database.new 'db/users.db'
db.execute('INSERT INTO users(name) VALUES("ena")')
db.execute('INSERT INTO users(name) VALUES("ganchan")')

db.execute('INSERT INTO comments(comment) VALUES("コメント１")')
db.execute('INSERT INTO comments(comment) VALUES("コメント２")')