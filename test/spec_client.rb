require 'test_helper'

describe Nideknil::Client do

  let(:site) {test_config[:options]}
  let(:new_user) {Nideknil::Client.new}
  let(:configured_user) {Nideknil::Client.new(test_config)}

  describe "instantiating new object" do
    it "with no inputs should initialize default access token variable" do
      new_user.access_token.must_be_instance_of OAuth::AccessToken
      new_user.access_token.secret.must_equal 'user secret'
      new_user.access_token.consumer.site.must_equal 'https://api.linkedin.com'
    end

    it "with configured tokens & keys should initialize configured access token variable" do
      configured_user.access_token.must_be_instance_of OAuth::AccessToken
      configured_user.access_token.secret.must_equal test_config[:user_secret]
    end

    it "without hash should raise error" do
      proc {Nideknil::Client.new(String)}.must_raise ArgumentError
    end
  end

  describe "#config" do
    it "should return default configured user when passed empty hash argument" do
      test_user = new_user.config(empty_hash={})
      test_user.secrets[:user_secret].must_equal "user secret"
    end

    describe "update user config" do
      let(:test_user){new_user.config({user_secret: "updated user secret"})}
      
      it "should update user secret" do
        test_user.secrets[:user_secret].must_equal "updated user secret"
      end

      it "should update user secret while keeping previously updated secrets" do
        test_user.config({api_secret: "updated api secret"})
        test_user.secrets[:api_secret].must_equal "updated api secret"
        test_user.secrets[:user_secret].must_equal "updated user secret"
      end
    end
  end

  describe "#client" do
    it "should return a valid OAuth::Consumer object configured for LinkedIn API" do
      oauthInstance = new_user.client
      oauthInstance.must_be_instance_of OAuth::Consumer
      oauthInstance.site.must_equal 'https://api.linkedin.com'
    end
  end

  describe "#get_access_token" do 
    it "with valid keys & tokens should return a valid OAuth::AccessToken object that requests GET from LinkedIn" do
      access_token = configured_user.get_access_token
      access_token.must_be_instance_of OAuth::AccessToken
      VCR.use_cassette('valid_access_token') do
        access_token.get("http://api.linkedin.com/v1/people/~").inspect.must_match "Net::HTTPOK 200" 
      end
    end

    it "with no keys & tokens should return unauthorized from LinkedIn" do
      invalid_token = new_user.get_access_token
      VCR.use_cassette('invalid_access_token') do
        invalid_token.get("http://api.linkedin.com/v1/people/~").inspect.must_match "Net::HTTPUnauthorized 401"
      end		
    end
  end
end