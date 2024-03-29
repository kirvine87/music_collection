 require_relative('../db/sql_runner.rb')
 require_relative('./album.rb')

 class Artist

   attr_accessor :name
   attr_reader :id

   def initialize(artist)
     @id = artist['id'].to_i() if artist['id']
     @name = artist['name']
   end

   def save()
     sql = "INSERT INTO artists (name)
     VALUES ($1) RETURNING id"
     values = [@name]
     result = SqlRunner.run(sql, values)
     @id = result[0]['id'].to_i
   end

   def Artist.delete_all()
     sql = "DELETE FROM artists"
     SqlRunner.run(sql)
   end

   def self.all()
     sql = "SELECT * FROM artists"
     artists = SqlRunner.run(sql)
     return artists.map{|artist| Artist.new(artist)}
   end

   def album()
     sql = "SELECT * FROM albums WHERE artist_id = $1"
     values = [@id]
     result = SqlRunner.run(sql, values)
     return result.map{|album| Album.new(album)}
   end

   def update()
     sql = "UPDATE artists SET
     name = $1 WHERE id = $2"

     values = [@name, @id]
     SqlRunner.run(sql, values)
   end

   def delete()
     sql = "DELETE FROM artists WHERE id = $1"
     values = [@id]
     SqlRunner.run(sql, values)
   end

   def self.artists_by_id(id)
     sql = "SELECT * FROM artists WHERE id = $1"
     values = [id]
     result = SqlRunner.run(sql, values)[0]
     return Artist.new(result)
   end

 end
