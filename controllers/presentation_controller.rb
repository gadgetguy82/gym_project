require("sinatra")
require("sinatra/contrib/all")

get "/presentation" do
  erb(:"presentation/class_diagram")
end

get "/presentation/website_sketch" do
  erb(:"presentation/website_sketch")
end

get "/presentation/database" do
  erb(:"presentation/database")
end

get "/presentation/constraints" do
  erb(:"presentation/constraints")
end

get "/presentation/query" do
  erb(:"presentation/query")
end

get "/presentation/gym" do
  erb(:"presentation/gym")
end
