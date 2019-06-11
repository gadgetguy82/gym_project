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

instructor_quantity = 10
member_quantity = 20
room_quantity = 5
gym_class_quantity = 5
booking_quantity = 10

gym = Gym.new(
  {
    "name" => "Agile Fitness",
    "start_peak" => "16:00",
    "stop_peak" => "19:00"
  }
)
gym.save

first_names = ["Andrew", "Betty", "Charles", "Daniella", "Eric", "Frieda", "Greg", "Helga", "Ian", "Jack", "Kevin", "Larry", "Matthew", "Nigel", "Oscar"]

last_names = ["Anderson", "Bailey", "Christie", "Dyer", "Egerton", "Fogel", "Glass", "Henley", "Innes", "Johnson", "Kent", "Little", "McIntyre", "Nichols", "Osbourne"]

instructors = []
instructor_quantity.times{
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

days = (1..28).to_a
months = (1..12).to_a
years = (1960..2000).to_a

streets = ["23 Springvalley Terrace", "14 Mortonhall Crescent", "35 Muirhouse Road"]

cities = ["Edinburgh", "Glasgow", "Stirling"]

postcodes = ["EH4 6HD", "G1 4BX", "FK4 7LY"]

phones = ["0131 223 4455", "0131 210 8732", "0131 430 9938"]

members = []
member_quantity.times{
  members.push(
    Member.new(
      {
        "first_name" => first_names.sample,
        "last_name" => last_names.sample,
        "date_of_birth" => "#{days.sample}/#{months.sample}/#{years.sample}",
        "street" => streets.sample,
        "city" => cities.sample,
        "postcode" => postcodes.sample,
        "phone" => phones.sample
      }
    )
  )
}
members.each{|member| member.save}

names = ["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "Indigo"]

capacities = [10, 20, 30, 40, 50]

rooms = []
room_quantity.times{
  rooms.push(
    Room.new(
      {
        "name" => names.sample,
        "capacity" => capacities.sample
      }
    )
  )
}
rooms.each{|room| room.save}

types = ["Calisthenics", "Judo", "Karate", "Yoga", "Zumba"]

gym_class1 = GymClass.new(
  {
    "type" => "Yoga",
    "start_date" => "2019-10-23",
    "start_time" => "10:00",
    "duration" => "1 hour",
    "room_id" => rooms.sample.id,
    "instructor_id" => instructors.sample.id
  }
)
gym_class2 = GymClass.new(
  {
    "type" => "Zumba",
    "start_date" => "2019-10-22",
    "start_time" => "11:00",
    "duration" => "30 minutes",
    "room_id" => rooms[2].id,
    "instructor_id" => instructors[1].id
  }
)
gym_class3 = GymClass.new(
  {
    "type" => "Calisthenics",
    "start_date" => "2019-10-20",
    "start_time" => "14:00",
    "duration" => "45 minutes",
    "room_id" => rooms[1].id,
    "instructor_id" => instructors[2].id
  }
)
gym_class1.save
gym_class2.save
gym_class3.save

booking1 = Booking.new(
  {
    "member_id" => members[1].id,
    "gym_class_id" => gym_class1.id
  }
)
booking2 = Booking.new(
  {
    "member_id" => members[1].id,
    "gym_class_id" => gym_class2.id
  }
)
booking3 = Booking.new(
  {
    "member_id" => members[2].id,
    "gym_class_id" => gym_class3.id
  }
)
booking4 = Booking.new(
  {
    "member_id" => members[3].id,
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
