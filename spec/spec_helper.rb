require 'rspec-puppet'

RSpec.configure do |c|
  c.module_path = File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'modules')
  c.manifest_dir = File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'manifests')
  c.parser = 'future' if ENV['FUTURE_PARSER'] == 'yes'
end
