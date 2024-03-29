require_relative("../db/sql_runner")
require_relative("gym_class")

class Member

  attr_reader :id
  attr_accessor :first_name, :last_name, :date_of_birth, :street, :city, :postcode, :phone, :membership

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @date_of_birth = options["date_of_birth"]
    @street = options["street"]
    @city = options["city"]
    @postcode = options["postcode"]
    @phone = options["phone"]
    @membership = options["membership"]
  end

  def save
    sql = "INSERT INTO members (
      first_name, last_name, date_of_birth, street,
      city, postcode, phone, membership
    ) VALUES (
      $1, $2, $3, $4, $5, $6, $7, $8
    ) RETURNING *"
    values = [@first_name, @last_name, @date_of_birth, @street, @city, @postcode, @phone, @membership]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update
    sql = "UPDATE members SET (
      first_name, last_name, date_of_birth, street,
      city, postcode, phone, membership
    ) = (
      $1, $2, $3, $4, $5, $6, $7, $8
    ) WHERE id = $9"
    values = [@first_name, @last_name, @date_of_birth, @street, @city, @postcode, @phone, @membership, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def classes
    sql = "SELECT gc.* FROM gym_classes gc INNER JOIN bookings b
    ON gc.id = b.gym_class_id WHERE b.member_id = $1"
    values = [@id]
    gym_classes_data = SqlRunner.run(sql, values)
    return GymClass.map_items(gym_classes_data)
  end

  def pretty_name
    return "#{first_name} #{last_name}"
  end

  def pretty_address
    return "#{street}<br\>#{city}<br\>#{postcode}"
  end

  def pretty_date
    date = Time.parse(@date_of_birth)
    return date.strftime("%d/%m/%Y")
  end

  def html_date
    date = Time.parse(@date_of_birth)
    return date.strftime("%Y-%m-%d")
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

  def self.premium_members
    sql = "SELECT * FROM members WHERE membership = 'Premium'"
    members_data = SqlRunner.run(sql)
    return map_items(members_data)
  end

  def self.standard_members
    sql = "SELECT * FROM members WHERE membership = 'Standard'"
    members_data = SqlRunner.run(sql)
    return map_items(members_data)
  end

  def self.get_matching_names(search)
    members = Member.all
    return members.find_all{|member| member.pretty_name.downcase.include?(search.downcase)}
  end

  def self.get_matching_premium_names(search)
    members = Member.premium_members
    return members.find_all{|member| member.pretty_name.downcase.include?(search.downcase)}
  end

  def self.get_matching_standard_names(search)
    members = Member.standard_members
    return members.find_all{|member| member.pretty_name.downcase.include?(search.downcase)}
  end

end
