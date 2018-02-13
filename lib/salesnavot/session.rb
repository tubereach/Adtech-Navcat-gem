module Salesnavot
  class Session
    def initialize(username, password)
      @capybara = Capybara::Session.new(ENV.fetch('driver').to_sym)
      auth = Salesnavot::Auth.new(@capybara)
      auth.login!(username, password)
    end

    def new_lead(config)
      Salesnavot::Lead.new(config, @capybara)
    end

    def create_campaign(config)
      campaign_test = Salesnavot::Campaign.new(config ,@capybara)
      campaign_test.goto_campaigns
      campaign_test.scrap
    end

    def create_adgroup(config, mode)
      campaign_test = Salesnavot::Adgroup.new(config ,@capybara)
      case mode
      when "apart"
        campaign_test.goto_campaigns_adgroups
        campaign_test.scrap
      when "joint"
        campaign_test.scrap
      end
    end

    def create_announce(config, mode)
      announce_on_browser = Salesnavot::Announce.new(config ,@capybara)
      case mode
      when "apart"
        announce_on_browser.goto_campaign_adgroups
        announce_on_browser.goto_adgroup
        announce_on_browser.create
      when "joint"
        announce_on_browser.create
      end
    end

    def create_call_to_action(config, mode)
      cta_on_browser = Salesnavot::CallToAction.new(config ,@capybara)
      case mode
      when "apart"
        cta_on_browser.goto_videos
        cta_on_browser.create
      when "joint"
        cta_on_browser.create
      end
    end

    def driver
      @capybara.driver
    end

  end
end
