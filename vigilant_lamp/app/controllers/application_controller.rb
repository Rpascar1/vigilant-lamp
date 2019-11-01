require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :session
    set :session_secret, "testing123"
  end

  get "/" do
    erb :"/index"
  end

  not_found do
  		status 404
  		erb :error
    end
    
  helpers do

    def current_user
      @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!session[:user_id]
    end

  end


end
