require 'highline/import'
require './background_repeater.rb'
DATE_FORMAT = '%Y-%m-%dT%H:%M:%SZ' # 2017-03-03T13:31:42Z
TEN_DIGIT_PHONE_REGEX = /\A((\d{3})-|(\d{3}-))?\d{3}-\d{4}\Z/ # 123-123-1234
REPEAT_INTERVAL = 1 # seconds

print_date = Proc.new {puts DateTime.now.strftime(DATE_FORMAT)}
printer = BackgroundRepeater.new print_date, REPEAT_INTERVAL
printer.start

loop do
  input = gets
  case input.strip
    when ''
      printer.stop
      ask('Phone Number?') {|q| q.validate = TEN_DIGIT_PHONE_REGEX}
      printer.start
    when "q"
      exit! 0
    else
      puts 'Invalid Input. Hit Enter to input phone number. q to quit.'
  end
end
