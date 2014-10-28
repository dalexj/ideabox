require_relative 'test_helper'
require_relative '../lib/idea_box'

class IdeaTest < Minitest::Test
  def test_defaults_rank_to_0
    idea = Idea.new
    assert_equal 0, idea.rank
  end

  def test_like_an_idea_adds_to_its_rank
    idea = Idea.new
    idea.like!
    assert_equal 1, idea.rank
    idea.like!
    assert_equal 2, idea.rank
    idea.like!
    assert_equal 3, idea.rank
  end

  def test_can_be_sorted
    ideas = [Idea.new("rank" => 4), Idea.new("rank" => 6), Idea.new("rank" => 2), Idea.new("rank" => 9)]
    assert_equal [9,6,4,2], ideas.sort.map(&:rank)
  end
end
