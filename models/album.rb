require('pg')
require_relative('../db/sql_runner')
require_relative('./artist')

class Album
  attr_accessor :title, :genre
  attr_reader :id, :artist_id

  def initialize( options )
    @artist_id = options['artist_id'].to_i
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']

  end

  def Album.delete_all
    sql = "
    DELETE FROM albums
    "
    SqlRunner.run(sql)
  end

  def save()
    sql = "
      INSERT INTO albums
      (
        artist_id,
        title,
        genre
      )
      VALUES
      ($1, $2, $3)
      RETURNING *
      "
    values = [@artist_id, @title, @genre]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def Album.all
    sql = "
    SELECT * FROM albums
    "

    album = SqlRunner.run(sql)
    return album.map {|album| Album.new(album) }
  end


  def artist
    sql = "
    SELECT * FROM artists WHERE id = $1
    "
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_data = result[0]
    artist = Artist.new(artist_data)
    # album = result.map {|artist| Artist.new(album)}
    return artist
  end

  def delete
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
