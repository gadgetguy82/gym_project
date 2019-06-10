require("pry")
require_relative("../models/booking")
require_relative("../models/gym_class")
require_relative("../models/room")
require_relative("../models/member")
require_relative("../models/instructor")
require_relative("../models/gym")

Booking.delete_all
GymClass.delete_all
Room.delete_all
Member.delete_all
Instructor.delete_all
Gym.delete_all

gym = Gym.new(
  {
    "name" => "Agile Fitness",
    "start_peak" => "16:00",
    "stop_peak" => "19:00"
  }
)
gym.save

first_names = ["Andrew", "Betty", "Charles", "Daniella", "Eric", "Frieda", "Greg", "Helga", "Ian"]
last_names = ["Anderson", "Bailey", "Christie", "Dyer", "Egerton", "Fogel", "Glass", "Henley", "Innes"]

10.times{
  instructors.push(
    Instructor.new(
      {
        "first_name" => first_names.sample,
        "last_name" => last_names.sample
      }
    )
  )
}
instructors.each{|instructor| instructor.save}

dobs = ["23/04/1990", "13/06/1970", "18/08/1960"]

streets = ["23 Springvalley Terrace", "14 Mortonhall Crescent", "35 Muirhouse Road"]

cities = ["Edinburgh", "Glasgow", "Stirling"]

postcodes = ["EH4 6HD", "G1 4BX", "FK4 7LY"]

phones = ["0131 223 4455", "0131 210 8732", "0131 430 9938"]

20.times{
  members.push(
    Member.new(
      {
        "first_name" => first_names.sample,
        "last_name" => last_names.sample,
        "date_of_birth" => dobs.sample,
        "street" => streets.sample,
        "cities" => cities.sample,
        "postcode" => postcodes.sample,
        "phone" => phones.sample
      }
    )
  )
}
members.each{|member| member.save}

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

gym_class1 = GymClass.new(
  {
    "type" => "Yoga",
    "start_date" => "2019-10-23",
    "start_time" => "10:00",
    "duration" => "1 hour",
    "room_id" => room1.id,
    "instructor_id" => instructor1.id
  }
)
gym_class2 = GymClass.new(
  {
    "type" => "Zumba",
    "start_date" => "2019-10-22",
    "start_time" => "11:00",
    "duration" => "30 minutes",
    "room_id" => room2.id,
    "instructor_id" => instructor1.id
  }
)
gym_class3 = GymClass.new(
  {
    "type" => "Calisthenics",
    "start_date" => "2019-10-20",
    "start_time" => "14:00",
    "duration" => "45 minutes",
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
