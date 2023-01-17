require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"

get "/" do
end

not_found do
  redirect "/"
end
