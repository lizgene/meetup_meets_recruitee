class MeetupClient
  require 'HTTParty'
  Settings.load!("config/settings.yml")
  BASE_URL = "https://api.meetup.com/"

  def initialize
    @api_key = Settings.api_keys[:meetup]
    @base_url = BASE_URL
  end

  def get_events(group_name)
    HTTParty.get("#{@base_url}#{group_name}/events?key=#{@api_key}&sign=true")
  end

  def get_rsvps(group_name, event_id)
    HTTParty.get("#{@base_url}#{group_name}/events/#{event_id}/rsvps?key=#{@api_key}&sign=true")
  end
end
