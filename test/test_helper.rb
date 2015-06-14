# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require "minitest/mock"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
# Minitest.backtrace_filter = Minitest::BacktraceFilter.new
MiniTest.module_eval do
  SILENCE = ['active_support/callbacks', 'active_support/notifications', 'gems/minitest', '/gems/spring', 'test_case.rb']
  def self.filter_backtrace(bt)
    bt.reject{|line| SILENCE.any?{|snippet| line.include?(snippet) } }
  end
end

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "files"
ActiveSupport::TestCase.fixtures :all

class ActiveSupport::TestCase
  def self.skip(name)
    define_method(name) do
      skip
    end
  end
end
