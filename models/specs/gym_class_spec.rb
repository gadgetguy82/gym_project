require("minitest/autorun")
require("minitest/rg")
require_relative("../gym_class")

class GymClassTest < Minitest::Test

  def setup
    @gym_class = GymClass.new(
      {
        "type" => "Yoga",
        "room_capacity" => 30
      }
    )
    @gym_class.save
  end

  def test_get_type
    assert_equal("Yoga", @gym_class.type)
  end

  def test_get_room_capacity
    assert_equal(30, @gym_class.room_capacity)
  end

end
