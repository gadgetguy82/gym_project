require_relative("../db/sql_runner")
require_relative("member")
require_relative("room")
require_relative("instructor")

class GymClass

  attr_reader :id
  attr_accessor :type, :start_date, :start_time, :duration, :spaces_taken, :spaces, :room_id, :instructor_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @type = options["type"]
    @start_date = options["start_date"]
    @start_time = options["start_time"]
    @duration = options["duration"]
    @spaces_taken = options["spaces_taken"].to_i if options["spaces_taken"]
    @spaces = options["spaces"].to_i if options["spaces"]
    @room_id = options["room_id"].to_i
    @instructor_id = options["instructor_id"].to_i
  end

  def save
    @spaces = 0
    @spaces_taken = 0
    sql = "INSERT INTO gym_classes (
      type, start_date, start_time, duration, spaces_taken, spaces, room_id, instructor_id
    ) VALUES (
      $1, $2, $3, $4, $5, $6, $7, $8
    ) RETURNING *"
    values = [@type, @start_date, @start_time, @duration, @spaces_taken, @spaces, @room_id, @instructor_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update
    sql = "UPDATE gym_classes SET (
      type, start_date, start_time, duration, spaces_taken, spaces, room_id, instructor_id
    ) = (
      $1, $2, $3, $4, $5, $6, $7, $8
    ) WHERE id = $9"
    values = [@type, @start_date, @start_time, @duration, @spaces_taken, @spaces, @room_id, @instructor_id, @id]
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

  def instructor
    sql = "SELECT i.* FROM instructors i INNER JOIN gym_classes gc
    ON i.id = gc.instructor_id WHERE gc.id = $1"
    values = [@id]
    instructor_data = SqlRunner.run(sql, values)[0]
    return Instructor.new(instructor_data)
  end

  def set_spaces
    previous = GymClass.find(@id)
    @spaces_taken = previous.spaces_taken
    @spaces = self.room.capacity.to_i - @spaces_taken
    update
  end

  def booked_space
    @spaces_taken += 1
    set_spaces
    update
  end

  def cancel_booking
    @spaces_taken -= 1
    set_spaces
    update
  end

  def html_date
    date = Time.parse(@start_date)
    return date.strftime("%Y-%m-%d")
  end

  def pretty_date
    date = Time.parse(@start_date)
    return date.strftime("%d/%m/%Y")
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
    upcoming = gym_classes.find_all{|gc| Time.parse(gc.start_date) > current_date}
    return upcoming
  end

end
