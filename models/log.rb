#Log
class Log
  include DataMapper::Resource
  property :id, Serial
  property :payload, Json
  property :repo, String
  property :branch, String
  
  property :created_at, DateTime
  property :updated_at, DateTime
  
  before :save, :load_data
  
  #Set the branch
  def load_data
    self.branch = self.payload['ref'].split('/')[2]
    self.repo = self.payload['repository']['name']
  rescue
    self.branch = nil
    self.repo = nil
  end
  
end
