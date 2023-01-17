require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'
require 'psych'

before do
  @user_data = Psych.load_file('users.yaml')
end

get "/" do
    redirect "/users"
end

get "/users" do
  erb :users
end

get "/user/:name" do
  @name = params[:name]
  @email = @user_data[@name.to_sym][:email]
  @interests = @user_data[@name.to_sym][:interests]
  @other_users = []
  @user_data.each do |name, values|
    next if name == @name.to_sym
    @other_users << name
  end
  @interests_total = count_interests
  erb :user
end

not_found do
  redirect "/"
end

helpers do
  def count_interests
    count = 0
    @user_data.each do |name, values|
      count += values[:interests].size
    end
    count
  end
end
