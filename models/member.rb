require_relative("../db/sql_runner")

def Member

  attr_reader :id
  attr_accessor :first_name, :last_name, :date_of_birth, :street, :city, :postcode, :phone

  def initialize(options)
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @date_of_birth = options["date_of_birth"]
    @street = options["street"]
    @city = options["city"]
    @postcode = options["postcode"]
    @phone = options["phone"]
  end

end
