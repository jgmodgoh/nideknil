$:.unshift File.expand_path('../../lib', __FILE__)
require 'nideknil'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'webmock'
require 'vcr'



def test_config
  { 
  	api_key:       'm36b3xn5zxq6',
    api_secret:    'OYjNv31lsEHMA6k5',
    user_token:    'b41df4e2-148c-46a0-a49a-1d81aa075b1f',
    user_secret:   '8b4ff6cc-5bdc-4403-893c-0819f9e9186a',
    options:       {site: 'https:://api.linkedin.com'}
  }
end

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock 
end
