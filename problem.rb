require 'dm-core'
require 'dm-migrations'
require 'json'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://postgres:12345@localhost/development') 

class Author
  include DataMapper::Resource

  property :id, Serial
  property :name, String
end

class Concept
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String


end

class Problem
  include DataMapper::Resource

  property :id, Serial
  property :completed, String
  property :title, String
  property :notes, String
  property :stakeholder, String
  
  def self.to_json
    self.all.map(&:to_json)
  end


  def completed?
    !(self.completed.nil? || self.completed == "")
  end

  def categorize
    words = self.notes.split(" ")
    words.each do |word|
      if word.match /[A-Z].+/
        Author.create(name: word) 
      else
        Concept.create(name: word) 
      end
    end
  end

  def to_h
    { title: title, notes: notes, stake_holder: stake_holder }
  end

  def to_json
    self.to_h.to_json
  end
end

class Tag
  attr_accessor :title

  def initialize(title)
    @title = title
  end

  def look_up_definition_on_wikipedia
    puts "To Be Implemented"
  end
end

DataMapper.finalize
