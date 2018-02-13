module Salesnavot
  class CallToAction < ScrapMethods
    def initialize(config, session)
      @call_to_action = config[:call_to_action] || ""

      @session = session
    end

    def to_hash
      {call_to_action: @call_to_action}
    end

    def to_json
      to_hash.to_json
    end

    def goto_videos
      puts "\n### Going to videos page"

      puts "--> Click on Goto Button"
      click_when_available('.goto-button')

      puts "--> Filling search"
      fill_when_available('.search-input', "Vidéos")

      puts "--> Click on first result"
      click_first_when_available('.component-wrap highlighted-text')

      puts "### Now on Videos page"
    end

    def create
      puts "\n### Started CTA creation"
      # We should start from videos page
      # If it isn't the case we user goto_videos before scraping
      puts "*** We're on videos page"

      puts "--> Clicking on add CTA under our video"
      click_on_video_cta

      puts "--> Filling headline url"
      fill_when_available("material-input[debugid=\"headline-input\"] input", @call_to_action.headline)

      puts "--> Filling display url"
      fill_when_available("material-input[debugid=\"display-url-input\"] input", @call_to_action.display_url)

      puts "--> Erasing final url"
      fill_when_available("material-input[debugid=\"destination-url-input\"] input", "")

      puts "--> Filling final url"
      fill_when_available("material-input[debugid=\"destination-url-input\"] input", @call_to_action.final_url)

      puts "--> Clicking save"
      click_when_available("material-button[debugid=\"save-button\"]")

      puts "/!\\ Sleeping 10s for debug purposes"
      sleep(10)
    end

    private

    def click_on_video_cta
      count = 0
      while(@session.all('.video-title-link').count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
        count = count + 1
        puts "/!\\ Waited 90s, something might be wrong, breaking" if count == 90
        break if count == 90
      end
      @session.all('.video-title-link').each do |link|
        if link.text == @call_to_action.video.get_name_from_url
          link.find(:xpath, '..').find("#cta-msg").click
        end
      end
    end
  end # End of Class
end # End of Module
