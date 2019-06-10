require_relative("../db/sql_runner")

class Room

  attr_reader :id
  attr_accessor :name, :capacity

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @capacity = options["capacity"].to_i
  end

  def save
    sql = "INSERT INTO rooms (
      name, capacity
    ) VALUES (
      $1, $2
    ) RETURNING *"
    values = [@name, @capacity]
    @id = SqlRunner.run(sql, values)[0]["id"]
  end

  def update
    sql = "UPDATE rooms SET (
      name, capacity
    ) = (
      $1, $2
    ) WHERE id = $3"
    values = [@name, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM rooms WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM rooms"
    rooms_data = SqlRunner.run(sql)
    return self.map_items(rooms_data)
  end

  def self.find(id)
    sql = "SELECT * FROM rooms WHERE id = $1"
    values = [id]
    room_data = SqlRunner.run(sql, values)[0]
    return Room.new(room_data)
  end

  def self.delete_all
    sql = "DELETE FROM rooms"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    return data.map{|room| Room.new(room)}
  end

end
