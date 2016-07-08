class RecruiteeClient
  BASE_URL = "https://api.recruitee.com"
  SUBDOMAIN = "springest"
  OFFER_ID = "ruby-on-rails-developer-in-amsterdam"

  def initialize
    @offer_id = OFFER_ID
    @base_url = BASE_URL
    @subdomain = SUBDOMAIN
  end

  def post_candidate(candidate_data)
    # https://api.recruitee.com/c/springest/careers/offers/ruby-on-rails-developer-in-amsterdam/candidates
    HTTParty.post(
      "#{@base_url}/c/#{@subdomain}/careers/offers/#{@offer_id}/candidates",
      body: candidate_data.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
