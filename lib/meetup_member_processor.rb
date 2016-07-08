class MeetupMemberProcessor
  require 'HTTParty'
  require 'pry-byebug'

  MEETUP_GROUP_NAMES = ['Software-Circus', 'Amsterdam-rb', 'NLHTML5', 'Webcrafters', 'WebDevelopment-Nederland', 'amsterdam-software-craftsmanship', 'Amsterdam-Code-Coffee', 'RailsGirls-NL', 'Techionistas-Coding-Class-for-women', 'GirlsinTechNL']

  def initialize
    @group_names = MEETUP_GROUP_NAMES
  end

  def process!
    @group_names.each do |group_name|
      upcoming_events = client.get_events(group_name)

      event_ids = extract_event_ids(upcoming_events)

      event_ids.each do |event_id|
        rsvps = client.get_rsvps(event_id)
        members = process_member_data(rsvps)

        members.each do |member|
          RecruiteeMemberProcessor.new(member).process!
        end
      end
    end
  end

  private

  def extract_event_ids(upcoming_events)
    debugger
  end

  def process_member_data(rsvps)
  end

  def client
    @client ||= MeetupClient.new
  end

# Data to grab from here:
# - name
# - id
# - bio
# - other_services
#   - twitter
#     - identifier
#   - linkedin
#     - identifier
end
