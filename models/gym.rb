require_relative("../db/sql_runner")

class Gym

  attr_reader :id
  attr_accessor :start_peak, :stop_peak

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @start_peak = options["start_peak"]
    @stop_peak = options["stop_peak"]
  end

  def save
    sql = "INSERT INTO gyms (
      name, start_peak, stop_peak
    ) VALUES (
      $1, $2, $3
    ) RETURNING *"
    values = [@name, @start_peak, @stop_peak]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update
    sql = "UPDATE gyms SET (
      name, start_peak, stop_peak
    ) = (
      $1, $2, $3
    ) WHERE id = $4"
    values = [@name, @start_peak, @stop_peak, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM gyms WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM gyms"
    gyms_data = SqlRunner.run(sql)
    return gyms_data.map{|gym| Gym.new(gym)}
  end

  def self.find(id)
    sql = "SELECT * FROM gyms WHERE id = $1"
    values = [id]
    gym_data = SqlRunner.run(sql, values)[0]
    return Gym.new(gym_data)
  end

  def self.return_this_gym
    return self.all[0]
  end

  def self.delete_all
    sql = "DELETE FROM gyms"
    SqlRunner.run(sql)
  end

end
