require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a heartbeat exists" do
  Heartbeat.all.destroy!
  request(resource(:heartbeats), :method => "POST", 
    :params => { :heartbeat => { :id => nil }})
end

describe "resource(:heartbeats)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:heartbeats))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of heartbeats" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a heartbeat exists" do
    before(:each) do
      @response = request(resource(:heartbeats))
    end
    
    it "has a list of heartbeats" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Heartbeat.all.destroy!
      @response = request(resource(:heartbeats), :method => "POST", 
        :params => { :heartbeat => { :id => nil }})
    end
    
    it "redirects to resource(:heartbeats)" do
      @response.should redirect_to(resource(Heartbeat.first), :message => {:notice => "heartbeat was successfully created"})
    end
    
  end
end

describe "resource(@heartbeat)" do 
  describe "a successful DELETE", :given => "a heartbeat exists" do
     before(:each) do
       @response = request(resource(Heartbeat.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:heartbeats))
     end

   end
end

describe "resource(:heartbeats, :new)" do
  before(:each) do
    @response = request(resource(:heartbeats, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@heartbeat, :edit)", :given => "a heartbeat exists" do
  before(:each) do
    @response = request(resource(Heartbeat.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@heartbeat)", :given => "a heartbeat exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Heartbeat.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @heartbeat = Heartbeat.first
      @response = request(resource(@heartbeat), :method => "PUT", 
        :params => { :heartbeat => {:id => @heartbeat.id} })
    end
  
    it "redirect to the heartbeat show action" do
      @response.should redirect_to(resource(@heartbeat))
    end
  end
  
end

