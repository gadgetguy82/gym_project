require("pry")
require_relative("../models/member")
require_relative("../models/gym_class")
require_relative("../models/booking")
require_relative("../models/room")
require_relative("../models/instructor")

Booking.delete_all
GymClass.delete_all
Room.delete_all
Member.delete_all
Instructor.delete_all

instructor1 = Instructor.new(
  {
    "first_name" => "George",
    "last_name" => "Clooney"
  }
)
instructor2 = Instructor.new(
  {
    "first_name" => "Brad",
    "last_name" => "Pitt"
  }
)
instructor1.save
instructor2.save

room1 = Room.new(
  {
    "name" => "Alpha",
    "capacity" => 10,
  }
)
room2 = Room.new(
  {
    "name" => "Bravo",
    "capacity" => 20,
  }
)
room1.save
room2.save

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
    "start_date" => "23/10/2019",
    "start_time" => "10:00",
    "duration" => "1 hour",
    "spaces" => room1.capacity,
    "room_id" => room1.id,
    "instructor_id" => instructor1.id
  }
)
gym_class2 = GymClass.new(
  {
    "type" => "Zumba",
    "start_date" => "22/10/2019",
    "start_time" => "11:00",
    "duration" => "30 minutes",
    "spaces" => room2.capacity,
    "room_id" => room2.id,
    "instructor_id" => instructor1.id
  }
)
gym_class3 = GymClass.new(
  {
    "type" => "Calisthenics",
    "start_date" => "20/10/2019",
    "start_time" => "14:00",
    "duration" => "45 minutes",
    "spaces" => room1.capacity,
    "room_id" => room1.id,
    "instructor_id" => instructor2.id
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
gym_class1.booked_space
booking2.save
gym_class2.booked_space
booking3.save
gym_class3.booked_space
booking4.save
gym_class3.booked_space

binding.pry
nil
