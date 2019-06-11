require("date")
require_relative("../db/sql_runner")
require_relative("member")
require_relative("room")
require_relative("instructor")

class GymClass

  attr_reader :id
  attr_accessor :type, :date_time, :duration, :spaces_taken, :room_id, :instructor_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @type = options["type"]
    if options["start_date"]
      @date_time = options["start_date"] + " " + options["start_time"]
    else
      @date_time = options["date_time"]
    end
    @duration = options["duration"]
    @spaces_taken = options["spaces_taken"].to_i if options["spaces_taken"]
    @room_id = options["room_id"].to_i
    @instructor_id = options["instructor_id"].to_i
  end

  def save
    @spaces_taken = 0
    sql = "INSERT INTO gym_classes (
      type, date_time, duration, spaces_taken, room_id, instructor_id
    ) VALUES (
      $1, $2, $3, $4, $5, $6
    ) RETURNING *"
    values = [@type, @date_time, @duration, @spaces_taken, @room_id, @instructor_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update
    sql = "UPDATE gym_classes SET (
      type, date_time, duration, spaces_taken, room_id, instructor_id
    ) = (
      $1, $2, $3, $4, $5, $6
    ) WHERE id = $7"
    values = [@type, @date_time, @duration, @spaces_taken, @room_id, @instructor_id, @id]
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

  def spaces
    return self.room.capacity -= @spaces_taken
  end

  def booked_space
    @spaces_taken += 1
    update
  end

  def cancel_booking
    @spaces_taken -= 1
    update
  end

  def create_date_time
    return DateTime.strptime(@date_time, "%Y-%m-%d %H:%M")
  end

  def date
    return self.create_date_time.to_date
  end

  def time
    return self.create_date_time.to_time
  end

  def pretty_date_time
    return self.create_date_time.strftime("%d/%m/%Y %H:%M")
  end

  def instructor_has_gym_class
    sql = "SELECT i.* FROM instructors i
    INNER JOIN gym_classes gc ON i.id = gc.instructor_id
    WHERE i.id = $1 AND gc.date_time <= $2
    AND gc.date_time + gc.duration >= $2"
    values = [@instructor_id, @date_time]
    instructors_data = SqlRunner.run(sql, values)
    return Instructor.map_items(instructors_data)
  end

  def check_instructor_free
    if self.instructor_has_gym_class != []
      return false
    else
      return true
    end
  end

  def room_has_gym_class
    sql = "SELECT r.* FROM rooms r
    INNER JOIN gym_classes gc ON r.id = gc.room_id
    WHERE r.id = $1 AND gc.date_time <= $2
    AND gc.date_time + gc.duration >= $2"
    values = [@room_id, @date_time]
    rooms_data = SqlRunner.run(sql, values)
    return Room.map_items(rooms_data)
  end

  def check_room_free
    if self.room_has_gym_class != []
      return false
    else
      return true
    end
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
    upcoming = gym_classes.find_all{|gc| gc.date_time > current_date}
    return upcoming
  end

end
