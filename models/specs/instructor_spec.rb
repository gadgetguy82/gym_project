require("minitest/autorun")
require("minitest/rg")

class InstructorTest < Minitest::Test

  def setup
    @instructor = Instructor.new(
      {
        "first_name" => "Jack",
        "last_name" => "Sparrow"
      }
    )
  end

  def test_get_first_name
    assert_equal("Jack", @instructor.first_name)
  end

  def test_get_last_name
    assert_equal("Sparrow", @instructor.last_name)
  end

end
