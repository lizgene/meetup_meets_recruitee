#!/usr/bin/env rake

require 'HTTParty'
require 'pry-byebug'

project_root = File.dirname(File.absolute_path(__FILE__))
# Dir.glob(project_root + '/config/*') { |file| require file }
Dir.glob(project_root + '/lib/*') { |file| require file }

task :meetup_meets_recruitee do
  interesting_meetup_members = MeetupMemberProcessor.new.get_interesting_members

  puts "Number of interesting members found in meetup: #{interesting_meetup_members.count}"

  puts "Importing interesting members into Recruitee..."
  RecruiteeMemberProcessor.new(interesting_meetup_members).create_profiles!
end
