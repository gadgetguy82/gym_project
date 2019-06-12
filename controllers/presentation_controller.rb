require("sinatra")
require("sinatra/contrib/all")

get "/presentation" do
  erb(:"presentation/class_diagram")
end
