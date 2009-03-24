class Heartbeats < Application
  # provides :xml, :yaml, :js

  def index
    @heartbeats = Heartbeat.all
    display @heartbeats
  end

  def show(id)
    @heartbeat = Heartbeat.get(id)
    raise NotFound unless @heartbeat
    display @heartbeat
  end

  def new
    only_provides :html
    @heartbeat = Heartbeat.new
    display @heartbeat
  end

  def edit(id)
    only_provides :html
    @heartbeat = Heartbeat.get(id)
    raise NotFound unless @heartbeat
    display @heartbeat
  end

  def create(heartbeat)
    # first check to see if a heartbeat has been received from
    # sensor within the past 2 minutes
    span = DateTime.parse((Time.now - 2.minutes).to_s)
    @heartbeat = Heartbeat.first(:sensor_id => heartbeat[:sensor_id],
                                 :updated_at.gte => span,
                                 :order => [:id.desc])
    if @heartbeat.nil? then
      @heartbeat = Heartbeat.create!(heartbeat)
    else
      @heartbeat.uptime = heartbeat[:uptime]
      @heartbeat.save!
    end



    # iterate over visitors
    visitors = params[:visitors].split('!') unless params[:visitors].nil?
    visitors ||= ''
    visitors.each do |visitor|
      (name, av_key) = visitor.split('.')
      avatar = Avatar.first(:sl_key => av_key)

      if avatar.nil? then
        (first_name, last_name) = name.split(' ')
        avatar = Avatar.create!(:first_name => first_name,
                                :last_name => last_name,
                                :sl_key => av_key)

        visit = Visit.create!(:sensor_id => heartbeat[:sensor_id],
                              :avatar_id => avatar.id)
      else
        # see if this visitor has been here within specified period
        visit = Visit.first(:sensor_id => heartbeat[:sensor_id],
                            :avatar_id => avatar.id,
                            :updated_at.gte => span,
                            :order => [:id.desc])
        if visit.nil? then
          visit = Visit.create!(:sensor_id => heartbeat[:sensor_id],
                                :avatar_id => avatar.id)
        else
          visit.updated_at = DateTime.parse(Time.now.to_s)
          visit.save!
        end
      end
    end

    render_text 'SUCCESS'
  end

  def update(id, heartbeat)
    @heartbeat = Heartbeat.get(id)
    raise NotFound unless @heartbeat
    if @heartbeat.update_attributes(heartbeat)
       redirect resource(@heartbeat)
    else
      display @heartbeat, :edit
    end
  end

  def destroy(id)
    @heartbeat = Heartbeat.get(id)
    raise NotFound unless @heartbeat
    if @heartbeat.destroy
      redirect resource(:heartbeats)
    else
      raise InternalServerError
    end
  end

end # Heartbeats
