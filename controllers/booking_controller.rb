require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/member")
require_relative("../models/gym_class")
also_reload("../models/*")

get "/bookings/:member_id" do
  @member = Member.find(params[:member_id])
  @gym_classes = GymClass.all
  erb(:"bookings/index")
end

post "/bookings/:member_id/:gc_id" do
  @booking = Booking.new(params[:member_id])
end
