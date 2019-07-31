 require('pry-byebug')
require_relative('./models/album.rb')
require_relative('./models/artist.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new(
  {
    'name' => 'Ricky'
  }
)

artist2 = Artist.new(
  {
    'name' => 'Jimmy'
  }
)

artist1.save()
artist2.save()

album1 = Album.new(
  {
    'name' => 'Ricky Album',
    'genre' => 'Indie',
    'artist_id' => artist1.id
  }
)

album2 = Album.new(
  {
    'name' => 'Slim jim',
    'genre' => 'Hip-Hop',
    'artist_id' => artist2.id
  }
)

album1.save()
album2.save()

album1.name = "Snippy Snappy"

album1.update()

artist1.name = "Rickstar"

artist1.update()

albums = Album.all()
artists = Artist.all()

binding.pry

nil
