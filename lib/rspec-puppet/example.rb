require 'rspec-puppet/support'
require 'rspec-puppet/example/define_example_group'
require 'rspec-puppet/example/class_example_group'
require 'rspec-puppet/example/function_example_group'
require 'rspec-puppet/example/function4x_example_group'
require 'rspec-puppet/example/host_example_group'

RSpec::configure do |c|
  def c.escaped_path(*parts)
    Regexp.compile(parts.join('[\\\/]'))
  end

  if RSpec::Version::STRING < '3'
    c.include RSpec::Puppet::DefineExampleGroup, :type => :define, :example_group => {
      :file_path => c.escaped_path(%w[spec defines])
    }
    c.include RSpec::Puppet::ClassExampleGroup, :type => :class, :example_group => {
      :file_path => c.escaped_path(%w[spec classes])
    }
    c.include RSpec::Puppet::FunctionExampleGroup, :type => :puppet_function, :example_group => {
      :file_path => c.escaped_path(%w[spec functions])
    }
    c.include RSpec::Puppet::Function4xExampleGroup, :type => :puppet4_function, :example_group => {
      :file_path => c.escaped_path(%w[spec functions4x])
    }
    c.include RSpec::Puppet::HostExampleGroup, :type => :host, :example_group => {
      :file_path => c.escaped_path(%w[spec hosts])
   }
  else
    c.include RSpec::Puppet::DefineExampleGroup, :type => :define, :file_path => c.escaped_path(%w[spec defines])
    c.include RSpec::Puppet::ClassExampleGroup, :type => :class, :file_path => c.escaped_path(%w[spec classes])
    c.include RSpec::Puppet::FunctionExampleGroup, :type => :puppet_function, :file_path => c.escaped_path(%w[spec functions])
    c.include RSpec::Puppet::Function4xExampleGroup, :type => :puppet4_function, :file_path => c.escaped_path(%w[spec functions4x])
    c.include RSpec::Puppet::HostExampleGroup, :type => :host, :file_path => c.escaped_path(%w[spec hosts])
  end
end
