# frozen_string_literal: true

class JokesController < ApplicationController

  before do
    redirect to "/login" unless current_user
  end

  # get '/' do
  #   @jokes = Joke.all
  # end

  get '/jokes' do
    @jokes = Joke.all
    erb :"/jokes"
  end

  get '/jokes/new' do
    binding.pry
    erb :"/jokes/new"
  end

  post '/jokes' do
    redirect to '/jokes/new' unless params[:body].present?

    @joke = current_user.jokes.build(body: params[:body])
    path = @joke.save ? "/jokes/#{@joke.id}" :'/jokes/new'

    redirect to path
  end

  get '/jokes/:id' do
    @joke = Joke.find(params[:id])
    erb :"/jokes/show"
  end

  get '/jokes/:id/edit' do
    @joke = Joke.find(params[:id])
    if @joke&.user == current_user
      erb :'jokes/edit_joke'
    else
      redirect to '/jokes'
    end
  end

  patch '/jokes/:id' do
    redirect to "/jokes/#{params[:id]}/edit" unless params[:body].present?

    @joke = Joke.find(params[:id])
    redirect to '/jokes/' unless @joke

    @joke.update(body: params[:body]) if @joke.user == current_user
    redirect to "/jokes/#{@joke.id}"
    end


  delete '/jokes/:id/delete' do
      @joke = Joke.find_by_id(params[:id])
      @joke.delete if @joke && @joke.user == current_user
      redirect to '/jokes'
  end
end
