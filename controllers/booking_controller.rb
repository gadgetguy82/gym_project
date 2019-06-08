require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/booking")
require_relative("../models/member")
require_relative("../models/gym_class")
also_reload("../models/*")

get "/bookings" do
  @bookings = Booking.all
  erb(:"bookings/index")
end

get "/bookings/:member_id" do
  @member = Member.find(params[:member_id])
  @gym_classes = GymClass.all
  erb(:"bookings/new")
end

post "/bookings/:member_id" do
  @booking = Booking.new(params)
  @booking.save
  erb(:"bookings/show")
end