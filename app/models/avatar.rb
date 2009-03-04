class Avatar
  include DataMapper::Resource

  has n, :sensors
  has n, :visits
  belongs_to :user
  
  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :key, String


end
