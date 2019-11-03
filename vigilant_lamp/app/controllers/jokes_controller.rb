# frozen_string_literal: true

class JokesController < ApplicationController

  before do
    redirect to "/login" unless current_user
  end

  get "/jokes/edit" do
     redirect to "/jokes/show"
  end

  get '/jokes' do
    @jokes = Joke.all
    erb :"/jokes/show"
  end

  get '/jokes/new' do
    erb :"/jokes/new"
  end

  get '/jokes/show' do
    erb :"/jokes/show"
  end

  post '/jokes' do
    redirect to '/jokes/new' unless params[:body].present?

    @joke = current_user.jokes.build(body: params[:body], status: params[:status], name: params[:name])
    path = @joke.save ? "/jokes/#{@joke.id}" :'/jokes/new'

    redirect to path
  end

  get '/jokes/:id' do
    @joke = Joke.find(params[:id])
    erb :"jokes/joke"

  end

  get "/jokes/:id/edit" do
    @joke = Joke.find(params[:id])
    if @joke.user_id != current_user.id
      session.destroy
      redirect to "/login"
    else
      erb:"/jokes/edit"
  end
end

  # get '/jokes/edit' do
  #    @joke = Joke.find_by_id(params[:id])
  #   if @joke&.user == current_user
  #     erb:"jokes/#{@joke.id}"
  #   else
  #     redirect to '/jokes'
  #   end
  # end

  patch '/jokes/:id' do
    redirect to "/jokes/#{params[:id]}/edit" unless params[:body].present?

    @joke = Joke.find(params[:id])
    redirect to '/jokes/' unless @joke

    @joke.update(body: params[:body]) if @joke.user == current_user
    redirect to "/jokes/#{@joke.id}"
    end

get '/jokes/:id/delete' do
  erb:'/jokes/:id'
end

  delete '/jokes/:id' do
    @joke = Joke.find_by_id(params[:id])
    path = @joke.delete ? "/jokes" :'/error'
    redirect to path
      # @joke = Joke.find_by_id(params[:id])
      # @joke.delete if @joke && @joke.user == current_user
      # redirect to '/jokes'
  end

end
