class Sensor
  include DataMapper::Resource
  
  belongs_to :avatar
  
  property :id, Serial
  property :is_active, Boolean
  property :rpc_key, String
  property :region, String
  property :x, Integer
  property :y, Integer
  property :z, Integer
  property :range, Integer
  property :version, Integer
  property :created_at, DateTime
  property :updated_at, DateTime


end
