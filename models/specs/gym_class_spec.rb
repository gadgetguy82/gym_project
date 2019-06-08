require("minitest/autorun")
require("minitest/rg")
require_relative("../gym_class")

class GymClassTest < Minitest::Test

  def setup
    GymClass.delete_all
    @gym_class = GymClass.new(
      {
        "type" => "Yoga",
        "start_time" => "10:00",
        "room_capacity" => 30
      }
    )
    @gym_class.save
  end

  def test_get_type
    assert_equal("Yoga", @gym_class.type)
  end

  def test_get_time
    assert_equal("10:00", @gym_class.start_time)
  end

  def test_get_room_capacity
    assert_equal(30, @gym_class.room_capacity)
  end

end
