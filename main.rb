require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

db = SQLite3::Database.new 'db/users.db'


get '/chii' do
   erb :chii
end

get '/yume' do
    'Hello ' + params['name']
end

get '/yume2' do
    locals = {
      name: params['name']
    }
    erb :yume2, :locals => locals
end

# get '/users' do
#     user_id = params['user_id']
#     #  db.execute('SELECT * FROM users WHERE id = ' + user_id) # [[1, "ena"]]
#     #  db.execute('SELECT * FROM users WHERE id = ' + user_id)[0] # [1, "ena"]
#     #  db.execute('SELECT * FROM users WHERE id = ' + user_id)[0][1] # "ena"
#     #全データからuser_idだけを引っ張ってきて、末尾で表示したい箇所を指定する。/users?user_id=1

#     # db.execute('SELECT * FROM users') # [[1, "ena"], [2, "ganchan"]]
#     # db.execute('SELECT * FROM users')[0] # [1, "ena"]
#     # db.execute('SELECT * FROM users')[0][0] # 1
#     # db.execute('SELECT * FROM users')[1][1]
#     #コメント部分/users?user_id=1

#     result = ''
#     db.execute('SELECT * FROM users').each{|user| # 1回目: [1, "ena"] 2回目: [2, "ganchan"]
#       result = result + user[1] + '<br>'
#     }
#     result
# end


get '/users' do
    input = {
      result: db.execute('SELECT * FROM users')
    }
    erb :users, :locals => input
end

post '/users' do
    user_name = params['user_name']
    db.execute('INSERT INTO users(name) VALUES("' + user_name + '")')
    redirect '/users'
    # ここでデータに入れる
end


get '/comments' do
    if params['filter'].nil? # パラメーターのfilterになにも指定していなかったら
        input_comment = {
          result: db.execute('SELECT * FROM comments')
        }
      else # そうではなかったら
        input_comment = {
          result: db.execute('SELECT * FROM comments WHERE comment LIKE "%' + params['filter'] + '%"')
        }
    end

    # input_comment = {
    #   result: db.execute('SELECT * FROM comments')
    # }
    erb :comments, :locals => input_comment
end

post '/comments' do
    comment = params['comment']
    db.execute('INSERT INTO comments(comment) VALUES("' + comment + '")')
    redirect '/comments'
    # ここでデータに入れる
end

get '/upload_form' do 
    erb :upload_form
end

post '/upload_image' do
    # ファイル名を取得 file_name に入れる
    file_name = params['image'][:filename]
    # File.writeで書き込む。 public/upload_images/アップロードしたファイル名, アップロードしたファイルデータを読み込む
    File.write('public/upload_images/' + file_name, params['image'][:tempfile].read)
    # imgでアップロードしたファイルを表示。閲覧ユーザーからはpublic以下しか見れないのでupload_imagesからpathがはじまっている
    p '<img src="/upload_images/' + file_name + '">' 
end

get '/uploads' do

    if params['id'].nil? # パラメーターのfilterになにも指定していなかったら
        inputimages = {
            result: db.execute('SELECT * FROM upload_images order by id desc')
        }
        erb :upload_images, :locals => inputimages

    else # そうではなかったら
        inputimage  = {
          result: db.execute("SELECT * FROM upload_images WHERE id = ?", params['id'])
        }
    end
end



post '/uploads' do
    # ファイル名を取得 file_name に入れる
    file_name = params['image'][:filename]
    # File.writeで書き込む。 public/upload_images/アップロードしたファイル名, アップロードしたファイルデータを読み込む
    File.write('public/upload_images/' + file_name, params['image'][:tempfile].read)
    # imgでアップロードしたファイルを表示。閲覧ユーザーからはpublic以下しか見れないのでupload_imagesからpathがはじまっている
    p '<img src="/upload_images/' + file_name + '">' 
    db.execute('INSERT INTO upload_images(file_name) VALUES("' + file_name + '")')
    redirect '/uploads'

end