require_relative("../db/sql_runner")

class Booking

  attr_reader :id
  attr_accessor :time, :member_id, :gym_class_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @time = options["time"]
    @member_id = options["member_id"]
    @gym_class_id = options["gym_class_id"]
  end

end
