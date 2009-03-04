class Visit
  include DataMapper::Resource
  
  belongs_to :sensor
  belongs_to :avatar
  
  property :id, Serial
  property :created_at, DateTime
  property :updated_at, DateTime


end
