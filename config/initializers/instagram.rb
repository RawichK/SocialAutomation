require "sinatra"
require "instagram"
enable :sessions

CALLBACK_URL = "http://socialautomation.herokuapp.com/callback"

Instagram.configure do |config|
  config.client_id = "ade9668ea9d143b8baf22de9b9569253"
  config.client_secret = "77823a9787ad4f94ab7fb49d775b46e7"
end