require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a visit exists" do
  Visit.all.destroy!
  request(resource(:visits), :method => "POST", 
    :params => { :visit => { :id => nil }})
end

describe "resource(:visits)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:visits))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of visits" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a visit exists" do
    before(:each) do
      @response = request(resource(:visits))
    end
    
    it "has a list of visits" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Visit.all.destroy!
      @response = request(resource(:visits), :method => "POST", 
        :params => { :visit => { :id => nil }})
    end
    
    it "redirects to resource(:visits)" do
      @response.should redirect_to(resource(Visit.first), :message => {:notice => "visit was successfully created"})
    end
    
  end
end

describe "resource(@visit)" do 
  describe "a successful DELETE", :given => "a visit exists" do
     before(:each) do
       @response = request(resource(Visit.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:visits))
     end

   end
end

describe "resource(:visits, :new)" do
  before(:each) do
    @response = request(resource(:visits, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@visit, :edit)", :given => "a visit exists" do
  before(:each) do
    @response = request(resource(Visit.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@visit)", :given => "a visit exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Visit.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @visit = Visit.first
      @response = request(resource(@visit), :method => "PUT", 
        :params => { :visit => {:id => @visit.id} })
    end
  
    it "redirect to the visit show action" do
      @response.should redirect_to(resource(@visit))
    end
  end
  
end

