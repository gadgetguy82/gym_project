require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/member")
also_reload("../models/*")

get "/members" do
  @members = Member.all
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
  @member = Member.find(params[:id])
  erb(:"members/show")
end

get "/members/:id/edit" do
  @member = Member.find(params[:id])
  erb(:"members/new")
end

post "/members/:id/edit" do
  @member = Member.new(params)
  @member.update
  erb(:"/members/show")
end

post "/members/:id/delete" do
  member = Member.find(params[:id])
  member.delete
  redirect to("/members")
end
