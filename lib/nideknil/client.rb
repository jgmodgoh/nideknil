require 'ostruct'

module Nideknil  
  class Client

    attr_reader :access_token

    def initialize(user_config={})
      raise ArgumentError, 'argument needs to be hash' unless user_config.instance_of? Hash
      @user_config = config(user_config)
      @access_token = get_access_token
    end

    def client
      OAuth::Consumer.new(user_config[:api_key], user_config[:api_secret], user_config[:options])
    end

    def get_access_token
      OAuth::AccessToken.new(client, user_config[:user_token], user_config[:user_secret])
    end

    def config(user_config)
      prepared_config = 
      {	api_key:     "api key",
        api_secret:  "api secret",
        user_token:  "user token",
        user_secret: "user secret",
        options:     {site: "https://api.linkedin.com"}
      }.merge(user_config)
      prepared_config
    end

    def user_config
      @user_config 
    end

  end
end