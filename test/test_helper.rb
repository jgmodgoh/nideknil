$:.unshift File.expand_path('../../lib', __FILE__)
require 'nideknil'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'webmock'
require 'vcr'

def userConfig
	{
	:apiKey => 'm36b3xn5zxq6',
	:apiSecret => 'OYjNv31lsEHMA6k5',
	:userToken => 'b41df4e2-148c-46a0-a49a-1d81aa075b1f',
	:userSecret => '8b4ff6cc-5bdc-4403-893c-0819f9e9186a',
	:configuration => {site: 'https:://api.linkedin.com'}
	}
end

VCR.configure do |c|  
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock 
end