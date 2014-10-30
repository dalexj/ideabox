class Idea
  include Comparable
  attr_reader :title, :description, :rank, :id, :tags
  def initialize(data = {})
    @title = data["title"]
    @description = data["description"]
    @rank = data["rank"] || 0
    @id = data["id"]
    @tags = data["tags"]
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank,
      "id" => id,
      "tags" => tags
    }
  end

  def like!
    @rank += 1
  end

  def <=>(other)
    other.rank <=> rank
  end

  def update(updated_data)
    @title = updated_data["title"]
    @description = updated_data["description"]
  end
end
