require_relative 'test_helper'
require_relative '../lib/idea_box'

class IdeaTest < Minitest::Test

  TEST_PATH = "test/ideabox_save"

  attr_reader :idea_store

  def setup
    File.delete TEST_PATH if File.exist? TEST_PATH
    @idea_store = IdeaStore.new(TEST_PATH)
  end

  def test_creates_path_if_doesnt_exist
    idea_store.save
    assert File.exist? TEST_PATH
  end

  def test_creates_ideas
    idea_store.create("title" => "test_title", "description" => "test_description")
    idea = idea_store.all.last
    assert_equal "test_description", idea.description
    assert_equal "test_title", idea.title
  end

  def test_creates_ideas_with_ids_if_not_given
    idea_store.create("title" => "test_title", "description" => "test_description")
    idea = idea_store.all.last
    assert_equal 1, idea.id
  end

  def test_finds_by_id
    idea_store.create("title" => "test_title", "description" => "test_description", "id" => 87)
    idea = idea_store.all.last
    assert_equal idea, idea_store.find("87")
    refute idea_store.find("7")
  end

  def teardown
    File.delete TEST_PATH if File.exist? TEST_PATH
  end
end
