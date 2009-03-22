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
    @visit = Visit.new(visit)
    if @visit.save
      redirect resource(@visit), :message => {:notice => "Visit was successfully created"}
    else
      message[:error] = "Visit failed to be created"
      render :new
    end
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
