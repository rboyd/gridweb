class Sensor
  include DataMapper::Resource
  
  property :id, Serial

  belongs_to :avatar
  has n, :visits

  property :created_at, DateTime
  property :updated_at, DateTime

  property :region, String, :nullable => false
  property :x, Float, :nullable => false
  property :y, Float, :nullable => false
  property :z, Float, :nullable => false
  property :version, Integer, :nullable => false
  property :range, Float, :nullable => false
  property :is_active, Boolean, :nullable => false, :default => true
  property :rpc_key, String, :nullable => false

end
