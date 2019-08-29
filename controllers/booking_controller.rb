require("sinatra")
require("sinatra/contrib/all") if development?
require_relative("../models/booking")
require_relative("../models/member")
require_relative("../models/gym_class")

get "/bookings" do
  @bookings = Booking.all
  erb(:"bookings/index")
end

get "/bookings/:member_id" do
  @member = Member.find(params[:member_id])
  if @member.membership == "Standard"
    @gym_classes = GymClass.standard_classes
  else
    @gym_classes = GymClass.upcoming_classes
  end
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
