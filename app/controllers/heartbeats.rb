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
    @heartbeat = Heartbeat.new(heartbeat)
    if @heartbeat.save
      redirect resource(@heartbeat), :message => {:notice => "Heartbeat was successfully created"}
    else
      message[:error] = "Heartbeat failed to be created"
      render :new
    end
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
