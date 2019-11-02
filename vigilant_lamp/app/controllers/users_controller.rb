# frozen_string_literal: true

class UsersController < ApplicationController
  # get"/user/:id" do
  #   if @user = User.find(params[:id])
  #     erb:"users/show"
  #   else
  #     redirect "/"
  #   end
  # end

  get '/signup' do
    if !logged_in?
      erb :"users/signup"
    else
      redirect to '/jokes'
    end
  end

  post '/signup' do
    if params[:username] != '' && params[:password] != ''
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/jokes/new'
    else
      erb :"/signup"
    end
  end

  get '/login' do
    unless current_user
      erb :"users/login"
    else
      erb :"/jokes/index"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      erb :"/jokes/index"
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.destroy
    redirect to '/'
  end
end
