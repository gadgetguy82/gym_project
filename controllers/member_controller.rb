require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/member")
also_reload("../models/*")

get "/member" do
  erb(:"members/index")
end

get "/member/new" do
  erb(:"members/new")
end
