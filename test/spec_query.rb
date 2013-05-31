require 'test_helper'

describe Query do 
  class Duck
    include Query
  end
    
  let(:duck) {Duck.new}
  let(:access_token) {Nideknil::Client.new(test_config).access_token}
  let(:criteria) {{"keywords"=> "developer", "country-code"=>"US"}}
  
  describe "#jobs_search_url" do
    it "with no criteria should return default search url" do 
      url = 'https://api.linkedin.com/v1/job-search?' 
      duck.jobs_search_url.must_equal url
    end 

    it "with criteria should append to default search url " do
      url = 'https://api.linkedin.com/v1/job-search?keywords=developer&country-code=US'
      #criteria = {"keywords"=> "developer", "country-code"=>"US"} 
      duck.jobs_search_url(criteria).must_equal url
    end
  end
  
  describe "#get_jobs_with_criteria" do
    it "should return jobs in response body that includes criteria specified" do
      VCR.use_cassette('job_search_by_criteria', :record => :new_episodes, :serialize_with => :json) do
        response = duck.get_jobs_with_criteria(access_token, criteria)
        response.body.must_include 'developer'
        response.body.must_include 'US'
      end
    end
  end
end