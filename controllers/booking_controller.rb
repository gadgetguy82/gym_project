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
  @booking.gym_class.booked_space
  erb(:"bookings/show")
end

post "/bookings/:id/delete" do
  booking = Booking.find(params[:id])
  booking.gym_class.cancel_booking
  booking.delete
  redirect to("/bookings")
end
