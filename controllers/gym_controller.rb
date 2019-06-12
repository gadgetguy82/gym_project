require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/gym")
also_reload("../models/*")

get "/gyms/show" do
  @gym = Gym.return_this_gym
  erb(:"gyms/show")
end

get "/gyms/:id/edit" do
  @gym = Gym.find(params[:id])
  erb(:"gyms/edit")
end

post "/gyms/:id/edit" do
  @gym = Gym.new(params)
  @gym.update
  erb(:"gyms/show")
end
