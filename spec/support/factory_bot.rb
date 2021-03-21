RSpec.configure do |config|
  # Rspec内でFactoryBotのメソッドを使用する際、「FactoryBot.」を省略できる
  config.include FactoryBot::Syntax::Methods
end