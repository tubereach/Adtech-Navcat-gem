module Salesnavot
  class Announce
    def initialize(config, session)
      @video_campaign = config[:campaign] || ""
      @adGroup = config[:adgroup] || ""
      @announce = config[:announce] || ""

      @session = session
    end

    def to_hash
      {video_campaign: @video_campaign, adGroup: @adGroup, announce: @announce}
    end

    def to_json
      to_hash.to_json
    end

    def goto_campaign_adgroups
      puts "\n### Going to selected campaign's adgroups list page"

      puts "--> Click on Goto Button"
      click_when_available('.goto-button')

      puts "--> Filling search"
      fill_when_available('.search-input', "Campagnes")

      puts "--> Click on Campaigns on results"
      click_first_when_available('.component-wrap highlighted-text')

      puts "--> Searching our campaign name"
      fill_when_available('.input-container input', @video_campaign.name)
      puts "--> Clicking on our campaign name"
      click_last_when_available('.suggestion')

      puts "### Now on Campaign page"
    end

    def goto_adgroup
      puts "\n### Going to selected adgroup page"
      # We should start from campaign page where adgroups are listed
      # If it isn't the case we use goto_campaign_adgroups before scraping
      puts "*** We're on the campaign page"

      puts "--> Searching our adgroup name"
      fill_when_available('.input-container input', @adGroup.name)
      puts "--> Clicking on our campaign name"
      click_last_when_available('.suggestion')

      puts "### Now on Adgroup page"
    end

    def create
      puts "\n### Started Announce creation"
      # We should start from an adgroup page
      # If it isn't the case we user goto_campaigns_adgroups before scraping
      puts "*** We're on adgroup page"

      puts "--> Click on + button"
      click_when_available('material-fab[navi-id="toolbelt-fab-add-button"]')

      puts "--> Filling video url"
      # fill_when_available('video-picker input', "https://www.youtube.com/watch?v=ETSlktbrgv8")
      fill_when_available('video-picker input', @announce.video_url)

      puts "--> Filling final url"
      # fill_when_available('url-input[sectiontiming="FinalUrl"] input', "www.test.ing.lol.fr")
      fill_when_available('url-input[sectiontiming="FinalUrl"] input', @announce.final_url)

      puts "--> Filling display url"
      puts "--- Erasing intenpestive values"
      fill_when_available('material-input[sectiontiming="DisplayUrl"] input', "")
      puts "--- Filling display url"
      # fill_when_available('material-input[sectiontiming="DisplayUrl"] input', "www.test.ing.lol.fr")
      fill_when_available('material-input[sectiontiming="DisplayUrl"] input', @announce.display_url)

      puts "--> Filling announce name"
      fill_when_available('material-input[sectiontiming="AdName"] input', @announce.name)

      puts "--> Click on save and continue"
      click_when_available('.btn-yes')

      puts "*** We're back again on adgroup page"
      puts "### Announce created."

      puts "/!\\ Sleeping 30s for debug purposes"
      sleep(30)
    end

    private

    def click_when_available(item_selector)
      while(@session.all(item_selector).count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
      end
      if @session.all(item_selector).count == 1
        puts "--- Clicking on element"
        @session.find(item_selector).click
      else
        puts "/!\\ Ambiguous selector, more than one result"
      end
    end

    def click_first_when_available(item_selector)
      while(@session.all(item_selector).count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
      end
      puts "--- Clicking on element"
      @session.all(item_selector).first.click
    end

    def click_last_when_available(item_selector)
      while(@session.all(item_selector).count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
      end
      puts "--- Clicking on element"
      @session.all(item_selector).last.click
    end

    def fill_when_available(item_selector, item_value)
      while(@session.all(item_selector).count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
      end
      if @session.all(item_selector).count == 1
        # puts "--- Sleeping an extra 1s"
        # sleep(1)
        puts "--- Filling element"
        @session.find(item_selector).set item_value
      else
        puts "/!\\ Ambiguous selector, more than one result"
      end
    end

    def selecting_format(format)
      while(@session.all('material-radio').count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
      end
      puts "--- Selecting format"
      case format
      when "InStream"
        @session.all('material-radio')[0].click
      when "Discovery"
        @session.all('material-radio')[1].click
      when "Bumper"
        @session.all('material-radio')[2].click
      else
        puts "/!\\ We should not be here, inside selecting formats"
      end
    end
  end # End of Class
end # End of Module
