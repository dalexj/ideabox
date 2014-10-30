require 'sinatra'
require 'rack/test'
require_relative 'test_helper'
require_relative '../lib/app'

class IdeaBoxAppTest < Minitest::Test
  include Rack::Test::Methods
  def app
    IdeaBoxApp
  end

  def test_index_has_ideas
    assert_includes get('/').body, "Existing Ideas"
  end

  def test_creates_an_idea
    post '/', idea: {"title" => "fake title","description" => "blah blah blah", "id" => 9000}
    assert_includes get('/').body, "fake title"
  end

  def test_deletes_an_idea
    post '/', idea: {"title" => "delete this idea","description" => "a", "id" => 9001}
    delete '/9001'
    refute_includes get('/').body, "delete this idea"
  end

  def test_liked_ideas_are_higher_up
    post '/', idea: {"title" => "like_test1", "description" => "a", "id" => 9002}
    post '/', idea: {"title" => "like_test2", "description" => "a", "id" => 9003}
    3.times do
      post '/9003/like'
    end
    post '/9002/like'
    response = get '/'
    assert (response.body =~ /like_test1/) > (response.body =~ /like_test2/)
  end

  def test_can_edit_ideas
    post '/', idea: {"title" => "going to be edited", "description" => "a", "id" => 9004}
    put '/9004', idea: {"title" => "is edited", "description" => "a"}
    response = get '/'
    assert_includes response.body, "is edited"
    refute_includes response.body, "going to be edited"
  end

  def teardown
    (9000..9010).each do |num|
      delete "/#{num}"
    end
  end
end
