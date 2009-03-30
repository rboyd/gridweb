module Merb
  module SensorsHelper

    def slurl(sensor)
      link_to "#{sensor.region} (#{sensor.x}, #{sensor.y}, #{sensor.z})", "http://slurl.com/secondlife/#{sensor.region}/#{sensor.x}/#{sensor.y}/#{sensor.z}/", :target => '_blank'
    end

    def link_to_profile(avatar)
      link_to "#{avatar.first_name} #{avatar.last_name}", "http://world.secondlife.com/resident/#{avatar.sl_key}", :target => '_blank'
    end

    def current_visitors(sensor)
      span = DateTime.parse((Time.now - 2.minutes).to_s)
      most_recent_heartbeat = sensor.heartbeats.first(:order => [:id.desc])

      # heartbeat is at least 2 minutes old, so report no visitors
      return [] if most_recent_heartbeat.updated_at < span

      # otherwise report t
      sensor.visits.all(:updated_at.eql => most_recent_heartbeat.updated_at)
    end

    def current_visitor_count(sensor)
      span = DateTime.parse((Time.now - 2.minutes).to_s)
      most_recent_heartbeat = sensor.heartbeats.first(:order => [:id.desc])

      # heartbeat is at least 2 minutes old, so report no visitors
      return [] if most_recent_heartbeat.updated_at < span

      sensor.visits.count(:updated_at.eql => most_recent_heartbeat.updated_at)
    end

    def visit_duration(visit)
      span = visit.updated_at - visit.created_at
      hours, minutes, seconds, frac = Date.day_fraction_to_time(span)
      duration = ""
      duration += "#{hours} hr" if hours > 0
      duration += "s" if hours > 1
      duration += ", " if hours > 0 and (minutes > 0 or seconds > 0)
      duration += "#{minutes} min" if minutes > 0
      duration += "s" if minutes > 1
      duration += ", " if minutes > 0 and seconds > 0
      duration += "#{seconds} sec" if seconds > 0
      duration += "s" if seconds > 1
    end
  end
end # Merb
