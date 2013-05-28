require 'test_helper'

describe "Nideknil::Client" do

	let(:config) {userConfig}
	let(:site) {userConfig[:configuration]}
	let(:user) {Nideknil::Client.new}
	let(:configuredUser) {Nideknil::Client.new(config)}
	
	describe "instantiating new object" do
		it "with configured tokens & keys should initialise valid accessToken variable" do
			configuredUser.accessToken.must_be_instance_of OAuth::AccessToken
		end

		it "without hash should raise error" do
			proc {Nideknil::Client.new(String)}.must_raise ArgumentError
		end
	end

	describe "#set_default_config" do
		it "should return default config hash" do
			defaultConfig = user.set_config(config)
			defaultConfig[:options][:site].must_equal 'https://api.linkedin.com'
		end
	end

	describe "#client" do
		it "should return a valid OAuth::Consumer object configured for LinkedIn API" do
			oauthInstance = user.client
			oauthInstance.must_be_instance_of OAuth::Consumer
			oauthInstance.site.must_equal 'https://api.linkedin.com'
		end
  end

  describe "#get_access_token" do 
  	it "with valid keys & tokens should return a valid OAuth::AccessToken object that requests GET from LinkedIn" do
	  	accessToken = configuredUser.get_access_token
	  	accessToken.must_be_instance_of OAuth::AccessToken
	  	VCR.use_cassette('valid_access_token') do
	  		accessToken.get("http://api.linkedin.com/v1/people/~").inspect.must_match "Net::HTTPOK 200" 
	  	end
	  end

	  it "with invalid keys & tokens should return unauthorized from LinkedIn" do
	  	invalid_token = user.get_access_token
	  	VCR.use_cassette('invalid_access_token') do
		  	invalid_token.get("http://api.linkedin.com/v1/people/~").inspect.must_match "Net::HTTPUnauthorized 401"
			end
	  end
  end

end