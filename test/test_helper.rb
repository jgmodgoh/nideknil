$:.unshift File.expand_path('../../lib', __FILE__)
require 'nideknil'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'webmock'
require 'vcr'



def test_config
  { 
    api_key:       'your key',
    api_secret:    'your secret',
    user_token:    'your token',
    user_secret:   'your secret',
    options:       {site: 'https:://api.linkedin.com'}
  }
end

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock 
end
