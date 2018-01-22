module Salesnavot
  class Auth
    def initialize(session)
      @session = session
    end
    def login!(username, password)
      url = "https://accounts.google.com/AccountChooser"
      puts "--> Visiting login screen at #{url}"
      @session.visit(url)

      # First we give username then click next
      puts "--> Adding email & password"
      @session.fill_in "identifierId", with: username
      puts "--> Click login"
      @session.find('#identifierNext').click

      puts "--> Waiting for password field..."
      sleep(0.2)

      @session.fill_in "password", with: password
      puts "--> Click password"
      @session.find('#passwordNext').click

      sleep(1)
      current_url = @session.driver.current_url()

      # Sometimes login is more complex
      if current_url.include?("myaccount.google.com")
        puts "--> On my account page, connecting to adwords..."
        continue_to_adwords = true
      end

      # Goto adwords
      if continue_to_adwords
        @session.visit("https://adwords.google.com/um/signin?hl=fr&sourceid=awo&subid=fr-ww-di-g-aw-a-awhp_1!o2")
        sleep(1)
        current_url = @session.driver.current_url();
        if current_url.include?("GlifWebSignIn")
          puts "--> Rewrite your password verification"
          @session.fill_in "password", with: password
          puts "--> Click password"
          @session.find('#passwordNext').click
          sleep(1)
        end

        sleep(1)
        current_url = @session.driver.current_url();
        if current_url.include?("Welcome")
          # select a where title = "TUBEREACH - Test (Okay)"
          puts "--> Selecting adword account"
          sleep(1)
          link_list = @session.find_link(title: "TUBEREACH - Test (Okay)").click
          puts "--> We should be on Adwords main panel now."
          continue_to_campaign = true
        end

        if continue_to_campaign
          campaign_test = Salesnavot::Campaign.new(
            {sales_nav_url: "https://adwords.google.com/um/identity?authuser=0&dst=/um/homepage?__e%3D6671079794"},
            @session)
          campaign_test.scrap
        else
          puts "--> We are not on adword panel"
        end

      else
        puts "--> A step must be missing"
      end

    end
  end
end
