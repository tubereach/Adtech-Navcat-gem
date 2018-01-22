module Salesnavot
  class Auth
    def initialize(session)
      @session = session
    end
    def login!(username, password)
      url = "https://accounts.google.com/AccountChooser"
      puts "visiting login screen at #{url}"
      @session.visit(url)

      # First we give username then click next
      puts "adding email & password"
      @session.fill_in "identifierId", with: username
      puts "click login"
      @session.find('#identifierNext').click

      # After that we fill password, why a while ?
      #while @session.all('#stream-container').count == 0
        puts "waiting for login"
        sleep(0.2)
      #end
      @session.fill_in "password", with: password
      @session.find('#passwordNext').click

      # Sometimes we're asked to verify things
      # p @session.all('#headingText')
      # p @session.find('#headingText').text
      # @session.fill_in "knowledgeLoginLocationInput", with: "Nantes"
      # @session.find('#next').click
      # if "Verify it's you"
      #   do stuffsales_nav_url:
      # else
      #   do other stuff
      # end

      #Goto adwords
      sleep(0.2)
      @session.visit("https://adwords.google.com/um/signin?hl=fr&sourceid=awo&subid=fr-ww-di-g-aw-a-awhp_1!o2")
      sleep(0.2)
      @session.fill_in "password", with: password
      sleep(0.2)
      @session.find('#passwordNext').click
      sleep(0.2)
      campaign_test = Salesnavot::Campaign.new(
        {sales_nav_url: "https://adwords.google.com/um/identity?authuser=0&dst=/um/homepage?__e%3D6671079794"},
        @session)
      campaign_test.scrap


    end

  end
end
