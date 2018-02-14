module Salesnavot
  class Auth < ScrapMethods
    def initialize(session)
      @session = session
    end

    def logout(session)
      @session.driver.browser.quit
    end

    def login!(username, password)
      url = "https://accounts.google.com/signin/v2/identifier?service=adwords&continue=https%3A%2F%2Fadwords.google.com%2Fum%2Fidentity%3Fhl%3Dfr%26sourceid%3Dawo%26subid%3Dfr-ww-di-g-aw-a-awhp_1!o2&hl=fr&ltmpl=signin&passive=0&skipvpage=true&flowName=GlifWebSignIn&flowEntry=ServiceLogin"

      puts "\n### Login procedure"

      puts "--> Visiting login screen"
      @session.visit(url)

      # Debug tools
      # @session.driver.save_screenshot('logging.png')
      # p @session.html

      # Global Google SignIn
      puts "--> Adding email"
      # Broken after google update ?
      fill_when_available("#identifierId", username)
      # fill_when_available("#Email", username)

      puts "--> Click next"
      # Broken after google update ?
      click_when_available('#identifierNext')
      # click_when_available('#next')

      puts "--> Adding passwd"
      # Broken after google update ?
      fill_when_available("#password input", password)
      # fill_when_available("#Passwd", password)

      # # Check if there is a captcha
      # if (@session.all('#captchaimg').count == 0)
      #   raise "/!\\ Epic fail: captcha detected"
      # end

      puts "--> Click next"
      # Broken after google update ?
      click_when_available('#passwordNext')
      # click_when_available('#signIn')

      # Verification
      puts "--> Looking for Verifications"
      puts "*** Sleeping 5s"
      sleep(5)
      # @session.driver.save_screenshot('before_verifs.png')
      unless @session.all('h1').empty?
        puts "/!\\ H1 detected, looking for Verifications..."
        @session.driver.save_screenshot('conf_step_1.png')
        puts "@@@ conf_step_1.png saved"
        p @session.all('h1')

        if(@session.all('h1').first.text == "Confirmez qu'il s'agit bien de vous")
          puts "--> \"Confirm it's you\" step"

          if(@session.all('span')[1].text == "Indiquer la ville dans laquelle vous vous connectez en général")
            puts "--> Click on specify main location"
            @session.all('button').first.click
            # @session.driver.save_screenshot('after_loc_verif.png')
            puts "--> Adding city name"
            @session.fill_in "answer", with: "Nantes"
            puts "*** Sleeping 1s"
            sleep(5)
            puts "--> Click next"
            # Probably protected by preventing click in center of element
            # @session.find("#submit").click
            @session.driver.execute_script("$('#submit').click")
            @session.driver.save_screenshot('after_loc_verif2.png')
            puts "@@@ after_loc_verif2.png saved"
            p @session.html
          end
          # If it's the first verif form we had
          if(@session.all("#recoveryBumpPickerEntry") == 1)
            @session.find("#recoveryBumpPickerEntry").click
            sleep(0.5)
            @session.fill_in "password", with: password
            sleep(0.5)
            @session.find('#passwordNext').click
            sleep(1.5)
            if(@session.all("#month").count == 1)
              @session.find("#month").find("option[value='1']").click
              @session.find("#year").find("option[value='2018']").click
              @session.find('#next').click
              sleep(1.5)
            end
            if(@session.all('#idvanyemailcollectNext').count == 1)
              @session.fill_in "idvAnyEmailInput", with: "julien@tubereach.com"
              @session.find('#idvanyemailcollectNext').click
              sleep(1.5)
            end
            if(@session.all('#idvanyemailverifyNext').count == 1)
              @session.fill_in "idvAnyEmailPin", with: "307528"
              @session.find('#idvanyemailverifyNext').click
              sleep(1.5)
            end
            if(@session.all('#next').count == 1)
              @session.find('#next').click
              sleep(1.5)
            end
          end # End of old? verification process
        else
          puts "??? There's a H1 but not in verifs"
        end # End of "Confirmez...."
      end # End of Verifications If

      # Waiting account selector to load
      while (@session.all('.aw-modal-popup-content  a').count == 0)
        puts "--> Waiting for account selector, retry in 1s"
        sleep(1)
      end
      puts "--> Click on selected account"
      @session.find_link(title: "TUBEREACH - Test (Okay)").click

      while (@session.all('awsm-skinny-nav').count == 0)
        puts "--- Waiting for adwords context to load, sleep 1s"
        sleep(1)
      end

      puts "### Logged in."
    # rescue
    #   puts "/!\\ Epic fail: Captcha detected"
    end
  end
end
