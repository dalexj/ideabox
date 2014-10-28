require_relative 'test_helper'
require_relative '../lib/idea_box'

class IdeaTest < Minitest::Test
  def test_creates_path_if_doesnt_exist
    path = "test/ideabox_save"
    File.delete path if File.exist? path
    IdeaStore.new(path).save
    assert File.exist? path
  end
end
