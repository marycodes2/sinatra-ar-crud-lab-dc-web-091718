
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    name = params[:name]
    content = params[:content]
    @post = Post.create(name: name, content:content)
    @post.save
    redirect "/posts"
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id/edit' do
    @post = Post.find(params["id"])
    erb :edit
  end

  get '/posts/:id/delete' do
    erb :delete
  end 

  delete '/posts/:id' do
    post = Post.find(params[:id])
    post.destroy
    # redirect "/posts"
    redirect "/posts/#{params[:id]}/delete"
  end

  # get 'posts/:id/delete' do
  #   erb :delete
  # end

  get '/posts/:id' do
    @post = Post.find(params["id"])
    erb :show
  end

  patch '/posts/:id' do
    post = Post.find(params["id"])
    name = params["name"]
    content = params["content"]
    post.update(name: name, content: content)
    redirect "posts/#{post.id}"
  end



end
