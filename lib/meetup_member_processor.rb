class MeetupMemberProcessor
  # http://www.meetup.com/Software-Circus/events/230518191/
  # http://www.meetup.com/Amsterdam-Elixir/events/231499168/
  # http://www.meetup.com/NLHTML5/events/229405357/
  # Past meetups hosted at Springest
  PAST_EVENTS = [
    { group: 'Software-Circus',
      event_id: 230518191 },
    { group: 'Amsterdam-Elixir',
      event_id: 231499168 },
    { group: 'NLHTML5',
      event_id: 229405357, },
  ]

  MEETUP_GROUP_NAMES = ['Software-Circus', 'Amsterdam-rb', 'NLHTML5', 'Webcrafters', 'WebDevelopment-Nederland', 'amsterdam-software-craftsmanship', 'Amsterdam-Code-Coffee', 'RailsGirls-NL', 'Techionistas-Coding-Class-for-women', 'GirlsinTechNL']

  TOPICS_OF_INTERESTS = /ruby|rails|php|phyton|backbone/i

  def initialize
    @group_names = MEETUP_GROUP_NAMES
  end

  def get_members
    members = []

    PAST_EVENTS.each do |event|
      rsvps = client.get_rsvps(event[:group], event[:event_id])
      members = process_member_data(rsvps)
    end

    # @group_names.each do |group_name|
    #   upcoming_events = client.get_events(group_name)
    #
    #   event_ids = extract_event_ids(upcoming_events)
    #   event_ids += EVENT_IDS
    #
    #   EVENT_IDS.each do |event_id|
    #     rsvps = client.get_rsvps(group_name, event_id)
    #     members = process_member_data(rsvps)
    #   end
    # end

    members.uniq
  end

  private

  def extract_event_ids(upcoming_events)
    upcoming_events.map { |event| event["id"] }
  end

  def process_member_data(rsvps)
    members = []

    rsvps.each do |rsvp|
      member_id = rsvp["member"]["id"]
      member_name = rsvp["member"]["name"]
      meetup_profile = "http://www.meetup.com/members/#{member_id}"

      member_data = {
        name: member_name,
        meetup_profile: meetup_profile,
        id: member_id
      }
      members << member_data
    end

    members
  end

  # TODO
  def filter_by_topics_of_interest(member_id)
    member = client.get_member(member_id)

    if topics = extract_member_topics(member)
      member_name = rsvp["member"]["name"]
      meetup_profile = "http://www.meetup.com/members/#{member_id}"
      member_data = { name: member_name, meetup_profile: meetup_profile, id: member_id }

      members << member_data if has_topics_of_interest?(topics)
    end
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
