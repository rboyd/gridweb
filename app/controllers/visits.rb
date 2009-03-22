class Visits < Application
  # provides :xml, :yaml, :js

  def index
    @visits = Visit.all
    display @visits
  end

  def show(id)
    @visit = Visit.get(id)
    raise NotFound unless @visit
    display @visit
  end

  def new
    only_provides :html
    @visit = Visit.new
    display @visit
  end

  def edit(id)
    only_provides :html
    @visit = Visit.get(id)
    raise NotFound unless @visit
    display @visit
  end

  def create(visit)
    sensor = Sensor.first(:id => visit[:sensor_id])
    # if sensor has been deleted, render 'NONEXISTANT'
    return(render_text('NONEXISTANT')) if sensor.nil?

    # iterate over visitors
    errors = 0
    visitors = params[:visitors].split('!')
    visitors.each do |visitor|
      (name, av_key) = visitor.split('.')
      avatar = Avatar.first(:sl_key => av_key)

      if avatar.nil? then
        (first_name, last_name) = name.split(' ')
        avatar = Avatar.create!(:first_name => first_name,
                                :last_name => last_name,
                                :sl_key => av_key)
      end

      visit = Visit.new(:sensor_id => sensor.id, :avatar_id => avatar.id)
      errors += 1 if !visit.save
    end
    return(render_text("SUCCESS")) unless errors > 0
    return(render_text("ERROR"))
  end

  def update(id, visit)
    @visit = Visit.get(id)
    raise NotFound unless @visit
    if @visit.update_attributes(visit)
       redirect resource(@visit)
    else
      display @visit, :edit
    end
  end

  def destroy(id)
    @visit = Visit.get(id)
    raise NotFound unless @visit
    if @visit.destroy
      redirect resource(:visits)
    else
      raise InternalServerError
    end
  end

end # Visits
