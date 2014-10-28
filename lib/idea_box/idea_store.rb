require 'yaml/store'

class IdeaStore
  attr_reader :ideas, :database
  def initialize
    @database = YAML::Store.new('db/ideabox')
    read
  end

  def all
    ideas
  end

  def find(id)
    ideas.find { |idea| idea.id.to_i == id.to_i }
  end

  def create(data)
    data["id"] ||= find_next_id
    ideas << Idea.new(data)
    save
  end

  def delete(id)
    ideas.reject! { |idea| idea.id.to_i == id.to_i}
    save
  end

  def update(id, data)
    delete(id)
    create(data)
  end

  def save
    database.transaction do
      database['ideas'] = ideas.map(&:to_h)
    end
  end

  def read
    database.transaction do
      @ideas = (database['ideas'] || []).map { |data| Idea.new(data) }
    end
  end

  def find_next_id
    return 1 if ideas.empty?
    ideas.map(&:id).map(&:to_i).max.next
  end
end
