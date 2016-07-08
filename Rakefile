#!/usr/bin/env rake

project_root = File.dirname(File.absolute_path(__FILE__))
# Dir.glob(project_root + '/config/*') { |file| require file }
Dir.glob(project_root + '/lib/*') { |file| require file }

task :test do
  MeetupMemberProcessor.new.process!
end
