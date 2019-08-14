require('pry')
require_relative('./models/album')
require_relative('./models/artist')

Album.delete_all
# Artist.delete_all


artist1 = Artist.new({
  'name' => 'Bob'
  })
  artist1.save()

artist2 = Artist.new({
  'name' => 'Jane'
  })
  artist2.save()

album1 = Album.new({
  'title' => 'White Album',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })
  album1.save()

album2 = Album.new({
  'title' => 'Black Album',
  'genre' => 'Pop',
  'artist_id' => artist2.id
  })
  album2.save()
album3 = Album.new({
  'title' => 'Grey Album',
  'genre' => 'Pop',
  'artist_id' => artist2.id
  })
  album3.save()



  binding.pry
  nil
