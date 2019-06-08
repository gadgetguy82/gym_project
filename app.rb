require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/member_controller")
require_relative("models/member")
also_reload("models/*")

get "/" do
  erb(:index)
end
