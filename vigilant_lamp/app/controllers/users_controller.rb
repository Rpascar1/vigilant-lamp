class UsersController < ApplicationController

  get"/user/:id" do
    if @user = User.find(params[:id])
      erb:"users/show"
    else
      redirect "/"
    end
  end

  get "/signup" do
    erb:"users/signup"

    # if params[:username] && params[:password]
    #   @user = User.create(params)
    #   session[:user_id] = @user.id
    #   redirect to "users/#{@user.id}"
    # end
  end

  post "/signup" do
    if params[:username] && params[:password]
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to "users/#{@user.id}"
    end
  end

  get "/login" do
    erb:"users/login"
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/jokes/new"
    end
  end

  get "/logout" do
    session.destroy
    redirect "/"
  end


end
