require_relative( '../db/sql_runner' )

class Level

  attr_reader( :level, :id )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @level = options['level']
  end

  def save()
    sql = "INSERT INTO levels
    (
      level
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@level]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM levels"
    results = SqlRunner.run( sql )
    return results.map { |level| Level.new( level ) }
  end

  def self.delete_all()
    sql = "DELETE FROM levels"
    SqlRunner.run( sql )
  end

end
