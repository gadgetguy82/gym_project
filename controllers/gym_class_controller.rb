require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/gym_class")
require_relative("../models/room")
also_reload("../models/*")

get "/gym_classes" do
  @gym_classes = GymClass.all
  erb(:"gym_classes/index")
end

get "/gym_classes/new" do
  @rooms = Room.all
  erb(:"gym_classes/new")
end

post "/gym_classes/new" do
  @gym_class = GymClass.new(params)
  @gym_class.save
  erb(:"gym_classes/show")
end

get "/gym_classes/:id" do
  @gym_class = GymClass.find(params[:id])
  erb(:"gym_classes/show")
end

get "/gym_classes/:id/edit" do
  @rooms = Room.all
  @gym_class = GymClass.find(params[:id])
  erb(:"gym_classes/new")
end

post "/gym_classes/:id/edit" do
  @gym_class = GymClass.new(params)
  @gym_class.update
  erb(:"gym_classes/show")
end

post "/gym_classes/:id/delete" do
  gym_class = GymClass.find(params[:id])
  gym_class.delete
  redirect to("/gym_classes")
end
