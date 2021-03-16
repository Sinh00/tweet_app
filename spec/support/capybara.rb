require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, options: {
      browser: :remote,
      url: ENV.fetch("SELENIUM_DRIVER_URL"),
      desired_capabilities: :chrome
    }
    Capybara.server_host = 'web'
    Capybara.app_host='http://web'
  end

  config.prepend_after(:each, type: :system) do
    Capybara.reset_sessions!
  end
end

# メモリ不足対策にブラウザのサイズを小さくする
Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')
  options.add_argument('window-size=1440,990')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end