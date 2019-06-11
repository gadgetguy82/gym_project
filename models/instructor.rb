require_relative("../db/sql_runner")
require_relative("gym_class")

class Instructor

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
  end

  def save
    sql = "INSERT INTO instructors (
      first_name, last_name
    ) VALUES (
      $1, $2
    ) RETURNING *"
    values = [@first_name, @last_name]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update
    sql = "UPDATE instructors SET (
      first_name, last_name
    ) = (
      $1, $2
    ) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM instructors WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def gym_classes
    sql = "SELECT * FROM gym_classes WHERE instructor_id = $1"
    values = [@id]
    gym_classes_data = SqlRunner.run(sql, values)
    return GymClass.map_items(gym_classes_data)
  end

  def pretty_name
    return "#{first_name} #{last_name}"
  end

  def self.all
    sql = "SELECT * FROM instructors"
    instructors_data = SqlRunner.run(sql)
    return self.map_items(instructors_data)
  end

  def self.find(id)
    sql = "SELECT * FROM instructors WHERE id = $1"
    values = [id]
    instructor_data = SqlRunner.run(sql, values)[0]
    return Instructor.new(instructor_data)
  end

  def self.delete_all
    sql = "DELETE FROM instructors"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    return data.map{|instructor| Instructor.new(instructor)}
  end

  def self.get_matching_names(search)
    instructors = Instructor.all
    return instructors.find_all{|instructor| instructor.pretty_name.include?(search)}
  end

end
