require_relative 'idea_box'

class IdeaBoxApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :method_override, true
  set :root, "lib/app"
  idea_store = IdeaStore.new


  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: {ideas: idea_store.all.sort}
  end

  post '/' do
    idea_store.create(params[:idea])
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = idea_store.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/:id' do |id|
    idea_store.update(id.to_i, params[:idea])
    redirect '/'
  end

  delete '/:id' do |id|
    idea_store.delete(id)
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = idea_store.find(id.to_i)
    idea.like!
    idea_store.update(id.to_i, idea.to_h)
    redirect '/'
  end
end