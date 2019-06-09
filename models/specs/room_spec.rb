require("minitest/autorun")
require("minitest/rg")
require_relative("../room")

class RoomTest < Minitest::Test

  def setup
    Room.delete_all
    @room = Room.new(
      {
        "name" => "Test",
        "capacity" => 20
      }
    )
  end

  def test_get_room_name
    assert_equal("Test", @room.name)
  end

  def test_get_room_capacity
    assert_equal(20, @room.capacity)
  end

end
