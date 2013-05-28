require 'ostruct'

module Nideknil  
	class Client
		
		attr_reader :accessToken
		
		def initialize(config={})
			raise ArgumentError, 'argument needs to be hash' unless config.instance_of? Hash
			@userConfig = set_config(config)
			@accessToken = get_access_token
		end

		def client
			OAuth::Consumer.new(user_config[:apiKey], user_config[:apiSecret], user_config[:options])
		end
	
		def get_access_token
			OAuth::AccessToken.new(client, user_config[:userToken], user_config[:userSecret])
		end

		def set_config(args)
			config = Hash.new
			config[:options] = {site: 'https://api.linkedin.com'}
			[:apiKey, :apiSecret, :userToken, :userSecret].each {|key| config[key] = args[key] || key }
			config
		end
	
		def user_config
			@userConfig 
		end

	end
end