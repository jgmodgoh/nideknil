
module Nideknil  
  class Client

    attr_reader :access_token, :secrets

    # Public: Initialize a Nideknil Client.
    #
    # user_secrets - The Hash containing user key, secrets and token. The Hash needs to be of
    #               
    #  user_secrets = {api_key:     "api key",
    #                 api_secret:  "api secret",
    #                 user_token:  "user token",
    #                 user_secret: "user secret"} 
    #               
    #                where the values are unique inputs for each user from LinkedIn.
    #
    # Examples
    #
    #   user_secrets = {api_key:     "123456789012",
    #                  api_secret:  "1234567890123456",
    #                  user_token:  "1234567-1234-1234-1234-123456789012",
    #                  user_secret: "1234567-1234-1234-1234-123456789012"}   
    #
    #   Nideknil::Client.new(user_secrets)
    #   # => #<OAuth::AccessToken:0x007fa3d3ce6b88 @token="user token", @secret="user secret", 
    #        @consumer=#<OAuth::Consumer:0x007fa3d3af2ef8 @key="api key", @secret="api secret", 
    #        @options={:signature_method=>"HMAC-SHA1", :request_token_path=>"/oauth/request_token", 
    #        :authorize_path=>"/oauth/authorize", :access_token_path=>"/oauth/access_token", 
    #        :proxy=>nil, :scheme=>:header, :http_method=>:post, :oauth_version=>"1.0", 
    #        :site=>"https://api.linkedin.com"}>, @params={}>
    #
    # Returns an OAuth::AccessToken with user configuration or default configuration if no arg is provided
    def initialize(user_secrets={})
      raise ArgumentError, 'argument needs to be hash' unless user_secrets.instance_of? Hash
      config(user_secrets)
      @access_token = get_access_token
    end

    def client
      OAuth::Consumer.new(secrets[:api_key], secrets[:api_secret], secrets[:options])
    end

    def get_access_token
      OAuth::AccessToken.new(client, secrets[:user_token], secrets[:user_secret])
    end

    def config(user_secrets)
      @secrets = @secrets ? @secrets.merge(user_secrets) : default_config.merge(user_secrets); 
      self
    end

    def default_config
      {
       api_key:     "api key",
       api_secret:  "api secret",
       user_token:  "user token",
       user_secret: "user secret",
       options:     {site: "https://api.linkedin.com"}
      }      
    end

  end
end