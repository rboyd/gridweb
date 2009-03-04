require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a sensor exists" do
  Sensor.all.destroy!
  request(resource(:sensors), :method => "POST", 
    :params => { :sensor => { :id => nil }})
end

describe "resource(:sensors)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:sensors))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of sensors" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a sensor exists" do
    before(:each) do
      @response = request(resource(:sensors))
    end
    
    it "has a list of sensors" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Sensor.all.destroy!
      @response = request(resource(:sensors), :method => "POST", 
        :params => { :sensor => { :id => nil }})
    end
    
    it "redirects to resource(:sensors)" do
      @response.should redirect_to(resource(Sensor.first), :message => {:notice => "sensor was successfully created"})
    end
    
  end
end

describe "resource(@sensor)" do 
  describe "a successful DELETE", :given => "a sensor exists" do
     before(:each) do
       @response = request(resource(Sensor.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:sensors))
     end

   end
end

describe "resource(:sensors, :new)" do
  before(:each) do
    @response = request(resource(:sensors, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@sensor, :edit)", :given => "a sensor exists" do
  before(:each) do
    @response = request(resource(Sensor.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@sensor)", :given => "a sensor exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Sensor.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @sensor = Sensor.first
      @response = request(resource(@sensor), :method => "PUT", 
        :params => { :sensor => {:id => @sensor.id} })
    end
  
    it "redirect to the sensor show action" do
      @response.should redirect_to(resource(@sensor))
    end
  end
  
end

