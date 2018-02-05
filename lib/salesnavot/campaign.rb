module Salesnavot
  class Campaign
    attr_reader :name, :budget
    def initialize(config, session)
      @name = config[:name] || ""
      @budget = config[:budget] || ""

      @session = session
    end

    def to_hash
      {name: @name, sales_nav_url: @sales_nav_url}
    end

    def to_json
      to_hash.to_json
    end

    def create_button_not_loaded
      @session.all('material-fab[navi-id="toolbelt-fab-add-button"]').count == 0
    end

    def click_create_button
      @session.find('material-fab[navi-id="toolbelt-fab-add-button"]').click
      sleep(2)
      @session.all(".material-popup-content .menu-content material-select-item").at(0).click
      sleep(2)
      @session.all(".construction-item-selection-card").at(3).click
      sleep(2)
      @session.find('.no-goal-option span').click
      while (@session.all('campaign-construction-panel campaign-name').count == 0)
        puts "Crete campaign page loading"
        sleep(0.2)

      end
    end

    def scrap
      puts "--> Strated campaign creation"
      @session.all('awsm-skinny-nav a').at(2).click
      puts "waiting for a button"
      while create_button_not_loaded
        sleep(0.1)
      end
      click_create_button
      @session.all('.remove-button').first.click
      sleep(1)
      @session.all('material-dialog material-button').at(1).click
      sleep(1)
      @session.find('campaign-construction-panel campaign-name').fill_in(with: @name)
      @session.find("budget-input money-input").fill_in(with: @budget)
      sleep(1)

      @session.find('save-cancel-buttons .btn-yes').click
    end
  end
end
