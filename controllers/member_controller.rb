require("sinatra")
require("sinatra/contrib/all") if development?
require_relative("../models/member")
require_relative("../models/gym_class")

get "/members" do
  @members = Member.all
  erb(:"members/index")
end

get "/members/new" do
  @date = GymClass.today
  erb(:"members/new")
end

post "/members/new" do
  @member = Member.new(params)
  @member.save
  erb(:"members/show")
end

get "/members/premium" do
  @members = Member.premium_members
  erb(:"members/premium")
end

get "/members/standard" do
  @members = Member.standard_members
  erb(:"members/standard")
end

post "/members/search" do
  @members = Member.get_matching_names(params[:search])
  erb(:"members/index")
end

post "/members/premium-search" do
  @members = Member.get_matching_premium_names(params[:search])
  erb(:"members/premium")
end

post "/members/standard-search" do
  @members = Member.get_matching_standard_names(params[:search])
  erb(:"members/standard")
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
