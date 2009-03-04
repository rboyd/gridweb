class Sensors < Application
  # provides :xml, :yaml, :js
  before :ensure_authenticated

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
    @sensor = Sensor.new(sensor)
    if @sensor.save
      redirect resource(@sensor), :message => {:notice => "Sensor was successfully created"}
    else
      message[:error] = "Sensor failed to be created"
      render :new
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
