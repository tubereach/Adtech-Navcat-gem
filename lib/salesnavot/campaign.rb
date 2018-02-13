module Salesnavot
  class Campaign < ScrapMethods
    attr_reader :name, :budget
    def initialize(config, session)
      @name = config[:name] || ""
      @budget = config[:budget] || ""

      @session = session
    end

    def to_hash
      {name: @name, budget: @budget}
    end

    def to_json
      to_hash.to_json
    end

    def goto_campaigns
      puts "\n### Going to campaigns list page"

      puts "--> Click on Goto Button"
      click_when_available('.goto-button')

      puts "--> Filling search"
      fill_when_available('.search-input', "Campagnes")

      puts "--> Click on Campaigns on results"
      click_first_when_available('.component-wrap highlighted-text')

      puts "### Now on Campaigns page"
    end

    def scrap
      puts "\n### Started Campaign creation"
      # We should start from campaigns page
      # If it isn't the case we use goto_campaigns
      puts "*** We're on Campaigns page"

      puts "--> Click on + button"
      click_when_available('material-fab[navi-id="toolbelt-fab-add-button"]')

      puts "--> Click on new campaign"
      click_first_when_available(".material-popup-content .menu-content material-select-item")

      puts "--> Click on Video card"
      click_nth_when_available(".construction-item-selection-card", 3)

      puts "--> Click on goalless Campaign"
      click_when_available('.no-goal-option span')

      puts "--> Click on ignore adgroups"
      click_first_when_available('.remove-button')

      puts "--> Click on ignore"
      click_when_available('.simple-dialog-button:last-child')

      puts "--> Filling name"
      fill_when_available('campaign-construction-panel campaign-name input', @name)

      puts "--> Filling budget"
      fill_when_available('budget-input money-input input', @budget)

      puts "--> Click on save and continue"
      click_when_available('save-cancel-buttons .btn-yes')

      puts "*** We're on created Campaign's adgroup list page"
      puts "### Campaign created."

      puts "/!\\ Sleeping 10s for debug purposes"
      sleep(10)
    end
  end
end
