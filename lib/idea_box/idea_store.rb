require 'yaml/store'

class IdeaStore
  attr_reader :ideas, :database
  def initialize(path = "db/ideabox")
    File.open(path, "w") {} unless File.exists? path
    @database = YAML::Store.new path
    read
  end

  def all
    ideas
  end

  def find(id)
    ideas.find { |idea| idea.id.to_i == id.to_i }
  end

  def select_tag(tag)
    return all unless tag
    ideas.select { |idea| idea.tags.include? tag }
  end

  def create(data)
    data["id"] ||= find_next_id
    data["tags"] = data["tags"].strip.split " " if data["tags"].is_a? String
    ideas << Idea.new(data)
    save
  end

  def delete(id)
    ideas.reject! { |idea| idea.id.to_i == id.to_i }
    save
  end

  def update(id, updated_data)
    find(id).update(updated_data)
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
