require('pg')
require_relative('../db/sql_runner')


class Artist
  attr_accessor :name
  attr_reader :id

  def initialize( options )
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "
      INSERT INTO artists
      (
        name
      )
      VALUES
      ($1)
      RETURNING *
      "
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def Artist.all
    sql = "
    SELECT * FROM artists
    "
    artist = SqlRunner.run(sql)
    return artist.map {|artist| Artist.new(artist)}
  end

  def albums
    sql = "
    SELECT * FROM albums WHERE artist_id = $1
    "
    values = [@id]
    result = SqlRunner.run(sql, values)
    # album_data = result[0]
    album = result.map {|album| Album.new(album)}
    return album
  end



end
