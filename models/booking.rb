require_relative("../db/sql_runner")
require_relative("gym_class")
require_relative("member")

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

  def update
    sql = "UPDATE bookings SET (
      start_time, member_id, gym_class_id
    ) = (
      $1, $2, $3
    ) WHERE id = $4"
    values = [@start_time, @member_id, @gym_class_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM bookings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def member
    sql = "SELECT m.* FROM members m INNER JOIN bookings b
    ON m.id = b.member_id WHERE id = $1"
    values = [@id]
    member_data = SqlRunner.run(sql, values)[0]
    return Member.new(member_data)
  end

  def gym_class
    sql = "SELECT gc.* FROM gym_classes gc INNER JOIN bookings b
    ON gc.id = b.gym_class_id WHERE id = $1"
    values = [@id]
    gym_class_data = SqlRunner.run(sql, values)[0]
    return GymClass.new(gym_class_data)
  end

  def self.all
    sql = "SELECT * FROM bookings"
    bookings_data = SqlRunner.run(sql)
    return self.map_items(bookings_data)
  end

  def self.find(id)
    sql = "SELECT * FROM bookings WHERE id = $1"
    values = [id]
    booking_data = SqlRunner.run(sql, values)[0]
    return Booking.new(booking_data)
  end

  def self.delete_all
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    return data.map{|booking| Booking.new(booking)}
  end

end
