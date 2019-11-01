class JokesController < ApplicationController

  get '/' do
    @joke = Joke.all
    erb:"/jokes/index"
  end

  get "/jokes/new" do
      if logged_in?
        erb:"/jokes/new"
      else
        redirect "/login"
      end
  end

  post "/jokes" do
    if params[:name] != "" && params[:body] != "" && parmas[:status] != ""
      @joke = Joke.new(params)
      @joke.user = current_user
      @joke.save
      redirect to "/jokes/index"
    else
      redirect "/jokes/new"
    end
  end


  get '/jokes/:id' do
    @joke = Joke.find_by_id(params[:id])
    erb:"/jokes/show"
  end

  get '/jokes/:id/edit' do
    @joke = Joke.find_by_id(params[:id])
    erb:"/jokes/edit"
  end

  patch "/jokes/:id" do
    if params[:name] != "" && params[:body] != "" && parmas[:status] != ""
      @joke = Joke.update(name: params[:name], body: params[:body], status: params[:status])
      @joke.user = current_user
      @joke.save
      redirect to "/jokes/index"
    else
      redirect "/jokes/new"
    end
  end

  delete "/jokes/:id" do
    @joke = joke.find_by_id(params[:id])
    @joke.destroy
    redirect "/jokesindex"
  end


end
