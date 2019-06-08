require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/member")
also_reload("../models/*")

get "/members" do
  erb(:"members/index")
end

get "/members/new" do
  erb(:"members/new")
end

post "/members/new" do
  @member = Member.new(params)
  @member.save
  erb(:"members/show")
end

get "/members/:id" do
  @member = Member.new(params)
  erb(:"members/show")
end

get "/members/:id/edit" do
  @member = Member.find(params[:id])
  erb(:"members/new")
end
