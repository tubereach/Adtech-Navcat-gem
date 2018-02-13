require "salesnavot/version"

require "capybara/dsl"
require "salesnavot/scrap_methods"
require "salesnavot/search"
require "salesnavot/adgroup"
require "salesnavot/announce"
require "salesnavot/campaign"
require "salesnavot/lead"
require "salesnavot/invite"
require "salesnavot/sent_invites"
require "salesnavot/friends"
require "salesnavot/profile_views"
require "salesnavot/session"
require "salesnavot/auth"
require "salesnavot/driver"

module Salesnavot
  def self.setup
    Capybara.run_server = false
  end
end
