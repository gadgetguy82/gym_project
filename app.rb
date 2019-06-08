require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/member_controller")
require_relative("controllers/gym_class_controller")

get "/" do
  erb(:index)
end
