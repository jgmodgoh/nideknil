$:.unshift File.expand_path('../../lib', __FILE__)
require 'nideknil'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'webmock'
require 'vcr'


def testuser_config
  { api_key:       'XXXxxXXXXX',
    api_secret:    'XXXXXXXXXX',
    user_token:    'XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXX',
    user_secret:   'XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXX',
    configuration: {site: 'https:://api.linkedin.com'}
  }
end

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock 
end
