# sqlite3っていうDBをいじる便利な道具を使います
require 'sqlite3'
# どれ使うの？
db = SQLite3::Database.new 'db/users.db'

# データの入れ物をつくる
db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT)')

#コメント一覧
db.execute('CREATE TABLE comments(id INTEGER PRIMARY KEY, comment TEXT)')

#画像投稿掲示板
db.execute('CREATE TABLE upload_images(id INTEGER PRIMARY KEY, file_name TEXT)')