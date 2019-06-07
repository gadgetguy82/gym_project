require("minitest/autorun")
require("minitest/rg")
require_relative("../booking")
require_relative("../member")
require_relative("../gym_class")

class BookingTest < Minitest::Test

  def setup
    # Booking.delete_all
    # GymClass.delete_all
    # Member.delete_all
    @member = Member.new(
      {
        "first_name" => "Joe",
        "last_name" => "Smith",
        "date_of_birth" => "23/04/1990",
        "street" => "23 Springvalley Terrace",
        "city" => "Edinburgh",
        "postcode" => "EH10 4PY",
        "phone" => "0131 223 4455"
      }
    )
    @member.save
    @gym_class = GymClass.new(
      {
        "type" => "Yoga",
        "room_capacity" => 30
      }
    )
    @gym_class.save
    @booking = Booking.new(
      {
        "time" => "10:00",
        "member_id" => @member.id,
        "gym_class_id" => @gym_class.id
      }
    )
  end

  def test_get_time
    assert_equal("10:00", @booking.time)
  end

  def test_get_member_id
    assert_equal(@member.id, @booking.member_id)
  end

  def test_get_class_id
    assert_equal(@gym_class.id, @booking.gym_class_id)
  end

end
