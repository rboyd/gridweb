class Exceptions < Merb::Controller
  
  # handle NotFound exceptions (404)
  def not_found
    render :format => :html
  end

  # handle NotAcceptable exceptions (406)
  def not_acceptable
    render :format => :html
  end

  def standard_error
    HoptoadNotifier.notify_hoptoad(request, session)
    render :format => :html
  end

  def internal_server_error
    HoptoadNotifier.notify_hoptoad(request, session)
    render :format => :html
  end

end
