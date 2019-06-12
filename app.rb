require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/member_controller")
require_relative("controllers/gym_class_controller")
require_relative("controllers/booking_controller")
require_relative("controllers/room_controller")
require_relative("controllers/instructor_controller")
require_relative("controllers/gym_controller")

get "/" do
  erb(:index)
end

get "/about_us" do
  erb(:about_us)
end
