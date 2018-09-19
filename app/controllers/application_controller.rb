require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::MethodOverride
  end

  get '/' do

  end

# displays all blog posts
  get '/posts' do
    @posts = Post.all
    erb :index
  end

# displays create post form
    get '/posts/new' do
      erb :new
    end

# creates a new post
  post '/posts' do
    @post = Post.create(name: params[:name], content: params[:content])
    redirect '/posts'
  end

# displays the edit post form
  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    @post.id = params[:id]
    erb :edit
  end

# updates post with new revisions
  patch '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect "/posts/#{@post.id}"
  end

  # displays blog post by id
    get '/posts/:id' do
      @post = Post.find_by_id(params[:id])
      erb :show
    end

# deletes post from posts on the show.erb
  delete '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @post.delete
    redirect to "/posts"
  end

end
