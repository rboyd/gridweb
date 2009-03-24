class Heartbeat
  include DataMapper::Resource
  
  property :id, Serial
  
  belongs_to :sensor
  
  property :created_at, DateTime
  property :updated_at, DateTime
  property :uptime, Float, :nullable => false

end
