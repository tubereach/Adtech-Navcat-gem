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

    def invite(sales_nav_profile_link, content)
      Salesnavot::Invite.new(sales_nav_profile_link, @capybara, content)
    end

    def create_campaign(config)
      campaign_test = Salesnavot::Campaign.new(config ,@capybara)
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

    def sent_invites
      Salesnavot::SentInvites.new(@capybara)
    end

    def profile_views
      Salesnavot::ProfileViews.new(@capybara)
    end

    def driver
      @capybara.driver
    end

    def friends
      Salesnavot::Friends.new(@capybara)
    end

    def search(identifier)
      Salesnavot::Search.new(identifier, @capybara)
    end
  end
end
