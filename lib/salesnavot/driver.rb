Capybara.register_driver :salesnavot_driver do |app|
  driver = Capybara::Selenium::Driver.new(app,
    :browser => :remote,
    :desired_capabilities => {"browser": "chrome", 'chromeOptions': {
        'args': ['no-sandbox', 'headless', 'disable-gpu', 'window-size=1920,1080']
    } }
  )
  driver
end
