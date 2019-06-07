require_relative("../db/sql_runner")

class GymClass

  attr_reader :id
  attr_accessor :type, :room_capacity

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @type = options["type"]
    @room_capacity = options["room_capacity"]
  end

  def save
    sql = "INSERT INTO classes (
      type, room_capacity
    ) VALUES (
      $1, $2
    ) RETURNING *"
    values = [@type, @room_capacity]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update
    sql = "UPDATE classes SET (
      type, room_capacity
    ) = (
      $1, $2
    ) WHERE id = $3"
    values = [@type, @room_capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM classes WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM classes"
    gym_classes_data = SqlRunner.run(sql)
    return self.map_items(gym_classes_data)
  end

  def self.delete_all
    sql = "DELETE FROM classes"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    return data.map{|gym_class| GymClass.new(gym_class)}
  end

end
