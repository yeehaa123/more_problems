require 'dm-core'
require 'dm-migrations'


$authors = []
$tags = []
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.rb")

class Problem
  include DataMapper::Resource

  property :id, Serial
  property :completed, String
  property :title, String
  property :notes, String
  
  def completed?
    !(self.completed.nil? || self.completed == "")
  end

  def categorize
    words = self.notes.split(" ")
    words.each do |word|
      if word.match /[A-Z].+/
        $authors << word
      else
        $tags << word
      end
    end
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
