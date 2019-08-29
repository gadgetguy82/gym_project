require("sinatra")
require("sinatra/contrib/all") if development?
require_relative("../models/room")

get "/rooms" do
  @rooms = Room.all
  erb(:"rooms/index")
end

get "/rooms/new" do
  erb(:"rooms/new")
end

post "/rooms/new" do
  @room = Room.new(params)
  @room.save
  erb(:"rooms/show")
end

post "/rooms/search" do
  @rooms = Room.get_matching_names(params[:search])
  erb(:"rooms/index")
end

get "/rooms/:id" do
  @room = Room.find(params[:id])
  erb(:"rooms/show")
end

get "/rooms/:id/edit" do
  @room = Room.find(params[:id])
  erb(:"rooms/new")
end

post "/rooms/:id/edit" do
  @room = Room.new(params)
  @room.update
  erb(:"rooms/show")
end

post "/rooms/:id/delete" do
  @room = Room.find(params[:id])
  @room.delete
  redirect to("/rooms")
end
