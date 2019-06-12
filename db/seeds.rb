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
gym_class_quantity = 10
booking_quantity = 15

gym = Gym.new(
  {
    "name" => "Agile Fitness",
    "start_peak" => "16:00",
    "stop_peak" => "19:00"
  }
)
gym.save

first_names = ["Andrew", "Betty", "Charles", "Daniella", "Eric", "Frieda", "Greg", "Helga", "Ian", "Jane", "Kevin", "Laura", "Matthew", "Natalie", "Oscar", "Pauline", "Richard", "Sarah", "Thomas", "Una", "Victor", "Wendy"]

last_names = ["Anderson", "Bailey", "Christie", "Dyer", "Egerton", "Fogel", "Glass", "Henley", "Innes", "Johnson", "Kent", "Little", "McIntyre", "Nichols", "Osbourne", "Pickles", "Quirke", "Raimi", "Stevenson", "Trent"]

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

memberships = ["Premium", "Standard"]

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
        "phone" => phones.sample,
        "membership" => memberships.sample
      }
    )
  )
}
members.each{|member| member.save}

names = ["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "Indigo"]

capacities = [10, 20, 30, 40, 50]

index = 0
rooms = []
room_quantity.times{
  rooms.push(
    Room.new(
      {
        "name" => names[index],
        "capacity" => capacities.sample
      }
    )
  )
  index += 1
}
rooms.each{|room| room.save}

types = ["Body Balance", "Calisthenics", "Core Conditioning", "Judo", "Karate", "Pilates", "Step Aerobics", "Yoga", "Zumba"]
year = 2019
times = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00"]
durations = ["1 hour", "50 minutes", "40 minutes", "30 minutes"]

gym_classes = []
gym_class_quantity.times{
  gym_classes.push(
    GymClass.new(
      {
        "type" => types.sample,
        "start_date" => "#{year}-#{months.sample}-#{days.sample}",
        "start_time" => times.sample,
        "duration" => durations.sample,
        "room_id" => rooms.sample.id,
        "instructor_id" => instructors.sample.id
      }
    )
  )
}
gym_classes.each do |gc|
  if gc.check_room_free && gc.check_instructor_free
    gc.save
  end
end

bookings = []
booking_quantity.times{
  bookings.push(
    Booking.new(
      {
        "member_id" => members.sample.id,
        "gym_class_id" => gym_classes.sample.id
      }
    )
  )
}
bookings.each do |booking|
  booking.save
  booking.gym_class.booked_space
end

# binding.pry
# nil
