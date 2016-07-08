class MeetupMemberProcessor
  MEETUP_GROUP_NAMES = ['Software-Circus', 'Amsterdam-rb', 'NLHTML5', 'Webcrafters', 'WebDevelopment-Nederland', 'amsterdam-software-craftsmanship', 'Amsterdam-Code-Coffee', 'RailsGirls-NL', 'Techionistas-Coding-Class-for-women', 'GirlsinTechNL']

  TOPICS_OF_INTERESTS = /ruby|rails|php|phyton|backbone/i

  def initialize
    @group_names = MEETUP_GROUP_NAMES
  end

  def get_interesting_members
    members = []

    @group_names.each do |group_name|
      upcoming_events = client.get_events(group_name)

      event_ids = extract_event_ids(upcoming_events)

      event_ids.each do |event_id|
        rsvps = client.get_rsvps(group_name, event_id)
        members = process_member_data(rsvps)
      end
    end

    members
  end

  private

  def extract_event_ids(upcoming_events)
    upcoming_events.map { |event| event["id"] }
  end

  def process_member_data(rsvps)
    members = []

    rsvps.each do |rsvp|
      member_id = rsvp["member"]["id"]
      member = client.get_member(member_id)

      if topics = extract_member_topics(member)
        member_name = rsvp["member"]["name"]
        meetup_profile = "http://www.meetup.com/members/#{member_id}"
        member_data = { name: member_name, meetup_profile: meetup_profile }

        members << member_data if has_topics_of_interest?(topics)
      end
    end

    members
  end

  def has_topics_of_interest?(topics)
    topics = topics.select { |topic| TOPICS_OF_INTERESTS.match(topic) }
    !topics.empty?
  end

  def extract_member_topics(member)
    topics = member["topics"]
    topics = topics.map { |topic| topic["name"] } if !topics.nil?

    topics
  end

  def client
    @client ||= MeetupClient.new
  end
end
