module Salesnavot
  class Campaign
    attr_reader :name
    def initialize(config, session)
      @sales_nav_url = config[:sales_nav_url] || ""
      @name = config[:name] || ""
      @session = session
    end

    def to_hash
      {name: @name, sales_nav_url: @sales_nav_url}
    end

    def to_json
      to_hash.to_json
    end

    def scrap
      @session.all('awsm-skinny-nav a').at(2).click
      puts "waiting"
      byebug
      # Going to campaign panel


    end
  end
end
