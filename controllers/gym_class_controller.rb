require("sinatra")
require("sinatra/contrib/all") if development?
require_relative("../models/gym_class")
require_relative("../models/room")
require_relative("../models/instructor")

get "/gym_classes" do
  @gym_classes = GymClass.all
  erb(:"gym_classes/index")
end

get "/gym_classes/new" do
  @rooms = Room.all
  @instructors = Instructor.all
  @date = GymClass.today
  erb(:"gym_classes/new")
end

post "/gym_classes/new" do
  @gym_class = GymClass.new(params)
  if !@gym_class.check_instructor_free
    @msg = "Instructor already scheduled for another class"
    erb(:"gym_classes/fail")
  elsif !@gym_class.check_room_free
    @msg = "Room already booked for another class"
    erb(:"gym_classes/fail")
  else
    @gym_class.save
    erb(:"gym_classes/show")
  end
end

get "/gym_classes/upcoming" do
  @gym_classes = GymClass.upcoming_classes
  erb(:"gym_classes/upcoming")
end

post "/gym_classes/search" do
  @gym_classes = GymClass.get_matching_types(params[:search])
  erb(:"gym_classes/index")
end

get "/gym_classes/:id" do
  @gym_class = GymClass.find(params[:id])
  erb(:"gym_classes/show")
end

get "/gym_classes/:id/edit" do
  @rooms = Room.all
  @instructors = Instructor.all
  @gym_class = GymClass.find(params[:id])
  erb(:"gym_classes/edit")
end

post "/gym_classes/:id/edit" do
  @gym_class = GymClass.new(params)
  if !@gym_class.check_instructor_free
    @msg = "Instructor already scheduled for another class"
    erb(:"gym_classes/fail")
  elsif !@gym_class.check_room_free
    @msg = "Room already booked for another class"
    erb(:"gym_classes/fail")
  elsif @gym_class.check_room_cap_reached
    @msg = "Room capacity is not enough to fit the current class"
    erb(:"gym_classes/fail")
  else
    @gym_class.update
    erb(:"gym_classes/show")
  end
end

post "/gym_classes/:id/delete" do
  gym_class = GymClass.find(params[:id])
  gym_class.delete
  redirect to("/gym_classes")
end
