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

      puts "waiting for password field"
      sleep(0.2)

      @session.fill_in "password", with: password
      @session.find('#passwordNext').click

      sleep(1)
      current_url = @session.driver.current_url()

      # Sometimes login is more complex
      if current_url.include?("myaccount.google.com")
        puts "On my account page, connecting to adwords..."
        continue_to_adwords = true
      end

      # Goto adwords
      if continue_to_adwords
        @session.visit("https://adwords.google.com/um/signin?hl=fr&sourceid=awo&subid=fr-ww-di-g-aw-a-awhp_1!o2")
        sleep(1)
        current_url = @session.driver.current_url();
        if current_url.include?("GlifWebSignIn")
          @session.fill_in "password", with: password
          @session.find('#passwordNext').click
          sleep(1)
        end

        sleep(1)
        current_url = @session.driver.current_url();
        if current_url.include?("Welcome")
          # select a where title = "TUBEREACH - Test (Okay)"
          puts "todo"
        end

        # campaign_test = Salesnavot::Campaign.new(
        #   {sales_nav_url: "https://adwords.google.com/um/identity?authuser=0&dst=/um/homepage?__e%3D6671079794"},
        #   @session)
        # campaign_test.scrap
      else
        puts "A step must be missing"
      end

    end
  end
end
