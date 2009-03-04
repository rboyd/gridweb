class Avatar
  include DataMapper::Resource

  has n, :sensors
  has n, :visits
  has 1, :user
  
  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :sl_key, String


end
