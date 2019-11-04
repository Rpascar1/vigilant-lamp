# frozen_string_literal: true

class JokesController < ApplicationController
  before do
    redirect to '/login' unless current_user.present?
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
    redirect to '/jokes/new' unless params[:body].present? && params[:status].present? && params[:name].present?
    @joke = current_user.jokes.build(body: params[:body], status: params[:status], name: params[:name])
    path = @joke.save ? "/jokes/#{@joke.id}" : '/jokes/new'
    redirect to path
  end

  get '/jokes/:id' do
    @joke = Joke.find(params[:id])
    if @joke.user_id != current_user.id
      redirect to '/error'
    else
      erb :"jokes/joke"
  end
  end

  get '/jokes/:id/edit' do
    @joke = Joke.find(params[:id])
    if @joke.user_id != current_user.id
      redirect to '/error'
    else
      erb :"/jokes/edit"
  end
  end

  patch '/jokes/:id' do
    redirect to "/jokes/#{params[:id]}/edit" unless params[:body].present?
    @joke = Joke.find(params[:id])
    redirect to '/jokes/' unless @joke
    @joke.update(body: params[:body], name: params[:name], status: params[:status]) if @joke.user == current_user
    redirect to "/jokes/#{@joke.id}"
  end

  get '/jokes/:id/delete' do
    @joke = Joke.find(params[:id])
    if @joke.user_id != current_user.id
      redirect to '/error'
    else
      erb :'/jokes/:id'
  end
  end

  delete '/jokes/:id' do
    @joke = Joke.find_by_id(params[:id])
    @joke.delete
    redirect to '/jokes/show'
  end
end
