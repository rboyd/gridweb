module Merb
  module SensorsHelper

    def slurl(sensor)
      link_to "#{sensor.region} (#{sensor.x}, #{sensor.y}, #{sensor.z})", "http://slurl.com/secondlife/#{sensor.region}/#{sensor.x}/#{sensor.y}/#{sensor.z}/", :target => '_blank'
    end

  end
end # Merb
