module Query
  
  def get_jobs_with_criteria(access_token, criteria={})
    #TODO need to allow for different formats
    format ||={'x-li-format' =>'xml'} 
    access_token.get(jobs_search_url(criteria), format)
  end

  def jobs_search_url(criteria={})
    "https://api.linkedin.com/v1/job-search?#{format_search_criteria(criteria)}"
  end

  def format_search_criteria(criteria={})
    criteria.map {|k,v| "#{k}=#{v}"}.join('&')
  end

end