class Sensors < Application
  # provides :xml, :yaml, :js

  def index
    @sensors = Sensor.all
    display @sensors
  end

  def show(id)
    @sensor = Sensor.get(id)
    raise NotFound unless @sensor
    display @sensor
  end

  def new
    only_provides :html
    @sensor = Sensor.new
    display @sensor
  end

  def edit(id)
    only_provides :html
    @sensor = Sensor.get(id)
    raise NotFound unless @sensor
    display @sensor
  end

  def create(sensor)
    avatar = Avatar.first(:sl_key => params[:av_key])
    return(render_text('NOACCOUNT')) if avatar.nil?

    @sensor = Sensor.new(sensor)
    @sensor.avatar = avatar
    
    if @sensor.save
      return render_text 'ACCEPT'
    else
      return render_text 'ERROR'
    end
  end

  def update(id, sensor)
    @sensor = Sensor.get(id)
    raise NotFound unless @sensor
    if @sensor.update_attributes(sensor)
       redirect resource(@sensor)
    else
      display @sensor, :edit
    end
  end

  def destroy(id)
    @sensor = Sensor.get(id)
    raise NotFound unless @sensor
    if @sensor.destroy
      redirect resource(:sensors)
    else
      raise InternalServerError
    end
  end

end # Sensors
