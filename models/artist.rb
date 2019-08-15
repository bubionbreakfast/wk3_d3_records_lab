require('pg')
require_relative('../db/sql_runner')


class Artist
  attr_accessor :name, :id


  def initialize( options )
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def Artist.find_by_id(id)
    # db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "
      SELECT * FROM artists WHERE id = $1"
    values = [id]
    # db.prepare("find_by_id", sql)
    result = SqlRunner.run(sql, values)

    # db.close()
    return Artist.new(result[0])
  end

  def update
    # db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "
      UPDATE artists
      SET (
        name,
        id
      ) =
      (
        $1, $2
      )
      WHERE id = $2
    "
    values = [@name, @id]
    SqlRunner.run(sql, values)

    # db.prepare("update", sql)
    # db.exec_prepared("update", values)
    # db.close()
  end

  def Artist.delete_all
    sql = "
    DELETE FROM artists
    "
    SqlRunner.run(sql)
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

# def update
#   sql = "
#   INSERT INTO
#   "
# end

end
