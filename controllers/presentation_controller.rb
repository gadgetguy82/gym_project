require("sinatra")
require("sinatra/contrib/all")

get "/presentation" do
  erb(:"presentation/class_diagram")
end

get "/presentation/website_sketch" do
  erb(:"presentation/website_sketch")
end

# get "/presentation/class_diagram" do
#   erb(:"presentation/class_diagram")
# end
#
# get "/presentation/class_diagram" do
#   erb(:"presentation/class_diagram")
# end
#
# get "/presentation/class_diagram" do
#   erb(:"presentation/class_diagram")
# end
