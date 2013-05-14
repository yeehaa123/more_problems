require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.rb")

class Problem
  include DataMapper::Resource

  property :id, Serial
  property :completed, Boolean
  property :title, String
  property :notes, String

  def completed?
    !(self.completed.nil? || self.completed == "")
  end

end

DataMapper.finalize
