require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/instructor")
also_reload("../models/*")

get "/instructors" do
  @instructors = Instructor.all
  erb(:"instructors/index")
end

get "/instructors/new" do
  erb(:"instructors/new")
end

post "/instructors/new" do
  @instructor = Instructor.new(params)
  @instructor.save
  erb(:"instructors/show")
end

get "/instructors/:id" do
  @instructor = Instructor.find(params[:id])
  erb(:"instructors/show")
end

get "/instructors/:id/edit" do
  @instructor = Instructor.find(params[:id])
  erb(:"instructors/new")
end

post "/instructors/:id/edit" do
  @instructor = Instructor.new(params)
  @instructor.update
  erb(:"/instructors/show")
end

post "/instructors/:id/delete" do
  instructor = Instructor.find(params[:id])
  instructor.delete
  redirect to("/instructors")
end
