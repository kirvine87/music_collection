 require_relative('../db/sql_runner.rb')
 require_relative('./artist.rb')

 class Album

   attr_accessor :name, :genre, :artist_id
   attr_reader :id

   def initialize(album)
     @id = album['id'].to_i() if album['id']
     @name = album['name']
     @genre = album['genre']
     @artist_id = album['artist_id'].to_i()
   end

   def save()
     sql = "INSERT INTO albums
     (name, genre, artist_id)
     VALUES ($1, $2, $3) RETURNING id"

     values = [@name, @genre, @artist_id]
     result = SqlRunner.run(sql, values)
     @id = result[0]['id'].to_i()
   end

   def Album.delete_all()
     sql = "DELETE FROM albums"
     SqlRunner.run(sql)
   end

   def self.all()
     sql = "SELECT * FROM albums"
     albums = SqlRunner.run(sql)
     return albums.map{|album| Album.new(album)}
   end

   def artist()
     sql = "SELECT * FROM artists where id = $1"
     values = [@artist_id]
     result = SqlRunner.run(sql, values)[0]
     return Artist.new(result)
   end

   def update()
     sql = "UPDATE albums SET
     (name, genre, artist_id) = ($1, $2, $3)
     WHERE id = $4"

     values = [@name, @genre, @artist_id, @id]
     SqlRunner.run(sql, values)
   end

   def delete()
     sql = "DELETE FROM albums where id = $1"
     value = [@id]
     SqlRunner.run(sql, value)
   end

   def self.album_by_id(id)
     sql = "SELECT * FROM albums WHERE id = $1"
     values = [id]
     result = SqlRunner.run(sql, values)[0]
     return Album.new(result)
   end

 end
