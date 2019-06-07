require_relative("../db/sql_runner")

class Member

  attr_reader :id
  attr_accessor :first_name, :last_name, :date_of_birth, :street, :city, :postcode, :phone

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @date_of_birth = options["date_of_birth"]
    @street = options["street"]
    @city = options["city"]
    @postcode = options["postcode"]
    @phone = options["phone"]
  end

  def save
    sql = "INSERT INTO members (
      first_name, last_name, date_of_birth, street,
      city, postcode, phone
    ) VALUES (
      $1, $2, $3, $4, $5, $6, $7
    ) RETURNING *"
    values = [@first_name, @last_name, @date_of_birth, @street, @city, @postcode, @phone]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update
    sql = "UPDATE members SET (
      first_name, last_name, date_of_birth, street,
      city, postcode, phone
    ) = (
      $1, $2, $3, $4, $5, $6, $7
    ) WHERE id = $8"
    values = [@first_name, @last_name, @date_of_birth, @street, @city, @postcode, @phone, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM members"
    members_data = SqlRunner.run(sql)
    return self.map_items(members_data)
  end

  def self.find(id)
    sql = "SELECT * FROM members WHERE id = $1"
    values = [id]
    member_data = SqlRunner.run(sql, values)[0]
    return Member.new(member_data)
  end

  def self.delete_all
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    return data.map{|member| Member.new(member)}
  end

end
