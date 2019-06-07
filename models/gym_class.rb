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

end
