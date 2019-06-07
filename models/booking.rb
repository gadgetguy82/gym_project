require_relative("../db/sql_runner")

class Booking

  attr_reader :id
  attr_accessor :start_time, :member_id, :gym_class_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @start_time = options["start_time"]
    @member_id = options["member_id"]
    @gym_class_id = options["gym_class_id"]
  end

  def save
    sql = "INSERT INTO bookings (
      start_time, member_id, gym_class_id
    ) VALUES (
      $1, $2, $3
    ) RETURNING *"
    values = [@start_time, @member_id, @gym_class_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

end
