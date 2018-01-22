require "spec_helper"
RSpec.describe Salesnavot do
  let (:session) {}
  after(:each) do
  #  session.driver.quit
  end

  it "has a version number" do
    expect(Salesnavot::VERSION).not_to be nil
  end

  it "asd"do
    session = Salesnavot::Session.new(ENV.fetch('username'), ENV.fetch('password'))
    session.driver.save_screenshot('logging.png')
    
    session.driver.save_screenshot('search')

    session.driver.quit
  end


end
