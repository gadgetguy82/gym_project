require_relative("../db/sql_runner")

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
    @id = SqlRunner.run(sql, values)[0]["id"]
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

end
