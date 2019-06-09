require_relative("../db/sql_runner")
require_relative("member")
require_relative("room")

class GymClass

  attr_reader :id
  attr_accessor :type, :start_time, :duration, :spaces, :room_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @type = options["type"]
    @start_time = options["start_time"]
    @duration = options["duration"]
    @spaces = options["spaces"].to_i
    @room_id = options["room_id"]
  end

  def save
    sql = "INSERT INTO gym_classes (
      type, start_time, duration, spaces, room_id
    ) VALUES (
      $1, $2, $3, $4, $5
    ) RETURNING *"
    values = [@type, @start_time, @duration, @spaces, @room_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update
    sql = "UPDATE gym_classes SET (
      type, start_time, duration, spaces, room_id
    ) = (
      $1, $2, $3, $4, $5
    ) WHERE id = $6"
    values = [@type, @start_time, @duration, @spaces, @room_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM gym_classes WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def members
    sql = "SELECT m.* FROM members m INNER JOIN bookings b
    ON m.id = b.member_id WHERE b.gym_class_id = $1"
    values = [@id]
    members_data = SqlRunner.run(sql, values)
    return Member.map_items(members_data)
  end

  def room
    sql = "SELECT r.* FROM rooms r INNER JOIN gym_classes gc
    ON r.id = gc.room_id WHERE gc.id = $1"
    values = [@id]
    room_data = SqlRunner.run(sql, values)[0]
    return Room.new(room_data)
  end

  def booked_space
    @spaces -= 1
    update
  end

  def self.all
    sql = "SELECT * FROM gym_classes"
    gym_classes_data = SqlRunner.run(sql)
    return self.map_items(gym_classes_data)
  end

  def self.find(id)
    sql = "SELECT * FROM gym_classes WHERE id = $1"
    values = [id]
    gym_class_data = SqlRunner.run(sql, values)[0]
    return GymClass.new(gym_class_data)
  end

  def self.delete_all
    sql = "DELETE FROM gym_classes"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    return data.map{|gym_class| GymClass.new(gym_class)}
  end

  def self.upcoming_classes
    gym_classes = self.all
    current_date = Time.now
  end

end
