# frozen_string_literal: true

class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :"users/signup"
    else
      redirect to '/jokes'
    end
  end

  post '/signup' do
    if params[:username] != '' && params[:password] != '' && params[:email].match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/jokes/new'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if current_user
      erb :"/jokes/index"
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      erb :"/jokes/index"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    session.destroy
    redirect to '/'
  end
end
