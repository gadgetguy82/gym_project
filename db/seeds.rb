require("pry")
require_relative("../models/member")
require_relative("../models/gym_class")
require_relative("../models/booking")

Booking.delete_all
GymClass.delete_all
Member.delete_all

member1 = Member.new(
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
member2 = Member.new(
  {
    "first_name" => "Bill",
    "last_name" => "Murray",
    "date_of_birth" => "13/06/1970",
    "street" => "14 Mortonhall Crescent",
    "city" => "Edinburgh",
    "postcode" => "EH13 8JY",
    "phone" => "0131 210 8732"
  }
)
member3 = Member.new(
  {
    "first_name" => "Robert",
    "last_name" => "De Niro",
    "date_of_birth" => "18/08/1960",
    "street" => "35 Muirhouse Road",
    "city" => "Edinburgh",
    "postcode" => "EH12 9PG",
    "phone" => "0131 430 9938"
  }
)
member1.save
member2.save
member3.save

gym_class1 = GymClass.new(
  {
    "type" => "Yoga",
    "start_time" => "10:00",
    "room_capacity" => 30
  }
)
gym_class2 = GymClass.new(
  {
    "type" => "Zumba",
    "start_time" => "11:00",
    "room_capacity" => 20
  }
)
gym_class3 = GymClass.new(
  {
    "type" => "Calisthenics",
    "start_time" => "14:00",
    "room_capacity" => 15
  }
)
gym_class1.save
gym_class2.save
gym_class3.save

booking1 = Booking.new(
  {
    "member_id" => member1.id,
    "gym_class_id" => gym_class1.id
  }
)
booking2 = Booking.new(
  {
    "member_id" => member1.id,
    "gym_class_id" => gym_class2.id
  }
)
booking3 = Booking.new(
  {
    "member_id" => member2.id,
    "gym_class_id" => gym_class3.id
  }
)
booking4 = Booking.new(
  {
    "member_id" => member3.id,
    "gym_class_id" => gym_class3.id
  }
)
booking1.save
booking2.save
booking3.save
booking4.save

binding.pry
nil
