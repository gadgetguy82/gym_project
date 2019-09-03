require("sinatra")
require("sinatra/contrib/all") if development?
require_relative("controllers/member_controller")
require_relative("controllers/gym_class_controller")
require_relative("controllers/booking_controller")
require_relative("controllers/room_controller")
require_relative("controllers/instructor_controller")
require_relative("controllers/gym_controller")
require_relative("controllers/presentation_controller")

get "/" do
  erb(:index)
end

get "/about_us" do
  erb(:about_us)
end
