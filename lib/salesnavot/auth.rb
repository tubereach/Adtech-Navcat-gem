module Salesnavot
  class Auth
    def initialize(session)
      @session = session
    end
    def login!(username, password)
      url = "https://accounts.google.com/signin/v2/identifier?service=adwords&continue=https%3A%2F%2Fadwords.google.com%2Fum%2Fidentity%3Fhl%3Dfr%26sourceid%3Dawo%26subid%3Dfr-ww-di-g-aw-a-awhp_1!o2&hl=fr&ltmpl=signin&passive=0&skipvpage=true&flowName=GlifWebSignIn&flowEntry=ServiceLogin"
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

      while (@session.all('.aw-modal-popup-content  a').count == 0)
        sleep(0.1)
      end
      @session.find_link(title: "TUBEREACH - Test (Okay)").click

      while (@session.all('awsm-skinny-nav').count == 0)
        puts "Waiting for adwords context to load"
        sleep(0.2)
      end
      sleep(2)
      #logged in!



      campaign_test = Salesnavot::Campaign.new({sales_nav_url: "lol"} ,@session)
      campaign_test.scrap






    end
  end
end
