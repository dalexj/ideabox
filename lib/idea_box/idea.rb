class Idea
  include Comparable
  attr_reader :title, :description, :rank, :id
  def initialize(data = {})
    @title = data["title"]
    @description = data["description"]
    @rank = data["rank"] || 0
    @id = data["id"]
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank,
      "id" => id
    }
  end

  def like!
    @rank += 1
  end

  def <=>(other)
    other.rank <=> rank
  end
end
