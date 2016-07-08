class RecruiteeClient
  BASE_URL = "https://api.recruitee.com"
  SUBDOMAIN = "springest"
  OFFER_ID = "ruby-on-rails-developer-in-amsterdam"

  def initialize(members)
    @api_key = api_key
    @base_url = BASE_URL
    @subdomain = SUBDOMAIN
    @members = members
  end

  def post_candidate(candidate_data)
    HTTParty.post(
      "#{@base_url}/c/#{@subdomain}/careers/offers/#{@offer_id}/candidates",
      body: candidate_data.to_json,
      headers: {'Content-Type' => 'application/json'}
    )
  end
end
