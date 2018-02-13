require "salesnavot/version"

require "capybara/dsl"
require "salesnavot/driver"
require "salesnavot/session"
require "salesnavot/scrap_methods"

require "salesnavot/auth"
require "salesnavot/campaign"
require "salesnavot/adgroup"
require "salesnavot/announce"

require "salesnavot/friends"
require "salesnavot/lead"
require "salesnavot/sent_invites"

module Salesnavot
  def self.setup
    Capybara.run_server = false
  end
end
