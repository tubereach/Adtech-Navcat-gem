module Salesnavot
  class Adgroup < ScrapMethods
    attr_reader :name, :bid
    def initialize(config, session)
      @name = config[:name] || ""
      @bid = config[:bid] || ""
      @video_campaign = config[:campaign] || ""

      @session = session
    end

    def to_hash
      {name: @name, bid: @bid}
    end

    def to_json
      to_hash.to_json
    end

    def goto_campaigns_adgroups
      puts "\n### Going to selected campaign's adgroup form"

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

    def scrap
      puts "\n### Started Adgroup creation"

      # After campaign creation we start from here
      # If it isn't the case we user goto_campaigns_adgroups before scraping
      puts "*** We're on adgroup page"

      puts "--> Click on + button"
      click_when_available('material-fab[navi-id="toolbelt-fab-add-button"]')

      puts "--> Filling adgroup name"
      fill_when_available('ad-group-name input', @name)

      puts "--> Filling adgroup bid"
      fill_when_available('bid-input input', @bid)

      puts "--> Click on ignore announces"
      click_when_available('.remove-button')

      puts "--> Click on ignore"
      click_when_available('.simple-dialog-button:last-child')

      puts "--> Click on save and continue"
      click_when_available('.btn-yes')

      # To save we need to choose a format
      # Available formats are "InStream", "Discovery", "Bumper"
      puts "--> Select format"
      selecting_format("InStream")
      puts "--> Click on save and continue"
      click_when_available('focus-trap material-button:first-child')

      puts "*** We're back again on adgroup page"
      puts "### Adgroup created."

      puts "/!\\ Sleeping 10s for debug purposes"
      sleep(10)
    end

    private

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
