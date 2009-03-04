class Visit
  include DataMapper::Resource
  
  belongs_to :sensor
  belongs_to :avatar
  
  property :id, Serial
  property :sensor_id, Integer
  property :avatar_id, Integer
  property :created_at, DateTime
  property :updated_at, DateTime


end
