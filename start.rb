require 'date'
require './background_repeater.rb'
DATE_FORMAT = '%Y-%m-%dT%H:%M:%SZ' # 2017-03-03T13:31:42Z
TEN_DIGIT_PHONE_REGEX = /^\d{3}-\d{3}-\d{4}$/ # 123-123-1234
REPEAT_INTERVAL = 1 # seconds

printer = BackgroundRepeater.new(REPEAT_INTERVAL) {puts DateTime.now.strftime(DATE_FORMAT)}
printer.start

def get_input(prompt)
  begin
    puts prompt
    input = gets.chomp
  end until yield input
  input
end

loop do
  input = gets
  case input.strip
    when ''
      printer.stop
      get_input ('Please enter a phone number. Format should be: 123-123-1234') {|num| TEN_DIGIT_PHONE_REGEX.match num}
      printer.start
    when 'q'
      exit! 0
    else
      puts 'Invalid Input. Hit Enter to input phone number. q to quit.'
  end
end
