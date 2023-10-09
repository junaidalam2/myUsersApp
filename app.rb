require 'sinatra'
require_relative './my_user_model.rb'

# set :bind, '0.0.0.0'
# set :port, '8080'

set('views', './views')
enable :sessions



get '/' do 
    "Welcome User!"
end
  
  
get '/users' do
    @users = User.all()
    erb :index
end


get '/check' do 

    if session[:user_id]
        "User #{session[:user_id]} is signed in."
    else
        "Not signed in"
    end

end


post '/users' do

    user_info_hash = {'firstname' => params['firstname'], 'lastname' => params['lastname'], 'age' => params['age'], 'password' => params['password'], 'email' => params['email']}
    id = User.create(user_info_hash)

end
  
  
delete '/users' do
    
    if params[:id].to_i == session[:user_id].to_i
      User.destroy(params[:id])
      session.clear
      status 204
    end 
  
end
  
  
post "/sign_in" do
  
    id = User.authenicate_login(params[:email], params[:password])
  
    if id
      session[:user_id] = id
      status 201
    else
      status 203
    end
    
end
  
  
delete "/sign_out" do
  
    if session[:user_id]
      session.clear
    end
  
    status 204

end
  
  
put "/users" do
    
    if session[:user_id]
      # user = User.new()
      User.update(session[:user_id], 'password', params[:password])
      "Password updated successfully."
    else
      "Please log in in order to change your password."
    end
  
end
  

# curl http://web-ud560f1c1-7aaa.docode.us.qwasar.io/users
# curl -X POST -i http://web-ud560f1c1-7aaa.docode.us.qwasar.io/users