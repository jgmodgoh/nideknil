$:.unshift File.expand_path('../../lib', __FILE__)
require 'nideknil'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'webmock'
require 'vcr'

def userConfig
	{
	:apiKey => 'XXXXXXXXX',
	:apiSecret => 'xxxxxxXXXXxxxx',
	:userToken => 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX',
	:userSecret => 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX',
	:configuration => {site: 'https:://api.linkedin.com'}
	}
end

VCR.configure do |c|  
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock 
end
