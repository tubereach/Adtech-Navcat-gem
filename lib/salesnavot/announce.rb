module Salesnavot
  class Announce < ScrapMethods
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
      fill_when_available('video-picker input', @announce.video.video_url)

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

      puts "/!\\ Sleeping 10s for debug purposes"
      sleep(10)
    end
  end # End of Class
end # End of Module
