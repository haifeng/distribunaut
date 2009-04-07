require File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper")

describe Distribunaut::Utils::Rinda do
  
  before(:each) do 
    begin
      DRb.start_service
      Rinda::RingServer.new(Rinda::TupleSpace.new)
    rescue Errno::EADDRINUSE => e
      # it's fine to ignore this, it's expected that it's already running.
      # all other exceptions should be thrown
    end
    begin
      rs.take([:testing, :String, nil, nil], 0)
    rescue Exception => e
    end
  end
  
  it "should have access to the ring server" do
    rs = Distribunaut::Utils::Rinda.ring_server
    rs.should_not be_nil
    rs.is_a?(Rinda::TupleSpace).should == true
  end
  
  it "should be able to register new service" do
    str = String.randomize(40)
    rs = Distribunaut::Utils::Rinda.ring_server
    serv = nil
    lambda { rs.read([:testing, :String, nil, "test_register-#{str}"], 0)[2] }.should raise_error(Rinda::RequestExpiredError)
    Distribunaut::Utils::Rinda.register(:app_name => :testing, :space => :String, :object => str, :description => "test_register-#{str}")
    serv = nil
    serv = rs.read([:testing, :String, nil, "test_register-#{str}"], 1)[2]
    serv.should_not be_nil
    serv.should == str
  end
  
  it "should be able to register or renew service(s)" do
    str = String.randomize(40)
    rs = Distribunaut::Utils::Rinda.ring_server
    serv = nil
    lambda { rs.read([:testing, :String, nil, "test_register_or_renew"], 0)[2] }.should raise_error(Rinda::RequestExpiredError)
    Distribunaut::Utils::Rinda.register_or_renew(:app_name => :testing, :space => :String, :object => str, :description => "test_register_or_renew")
    serv = nil
    serv = rs.read([:testing, :String, nil, "test_register_or_renew"], 1)[2]
    serv.should_not be_nil
    serv.should == str
    
    str2 = String.randomize(40)
    Distribunaut::Utils::Rinda.register_or_renew(:app_name => :testing, :space => :String, :object => str2, :description => "test_register_or_renew")
    serv = nil
    serv = rs.read([:testing, :String, nil, "test_register_or_renew"], 1)[2]
    serv.should_not be_nil
    serv.should == str2
    serv.should_not == str
  end
  
end