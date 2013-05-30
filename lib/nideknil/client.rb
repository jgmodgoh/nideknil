require 'ostruct'

module Nideknil  
  class Client

    attr_reader :access_token

    # Public: Initialize a Nideknil Client.
    #
    # user_config - The Hash containing user key, secrets and token. The Hash needs to be of
    #               
    #  user_config = {api_key:     "api key",
    #                api_secret:  "api secret",
    #                user_token:  "user token",
    #                user_secret: "user secret"} 
    #               
    #                where the values are unique inputs for each user from LinkedIn.
    #
    # Examples
    #
    #   user_config = {api_key:     "123456789012",
    #                api_secret:  "1234567890123456",
    #                user_token:  "1234567-1234-1234-1234-123456789012",
    #                user_secret: "1234567-1234-1234-1234-123456789012"}   
    #
    #   Nideknil::Client.new(user_config)
    #   # => #<OAuth::AccessToken:0x007fa3d3c28818 @token="XXXX", @secret="XXXX", @consumer="XXXX", @params={XXXX}>
    #
    # Returns an OAuth::AccessToken with user configuration or default configuration if no arg is provided
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