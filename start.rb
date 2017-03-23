require 'highline/import'
print_seconds = true
printer = Thread.new do
  loop do
    Thread.stop unless print_seconds
    dt = DateTime.now
    puts(dt.strftime "%Y-%m-%dT%H:%M:%SZ")
    sleep 1
  end
end
printer.run
loop do
  input = gets
  puts input
  case input.strip
    when ""
      print_seconds = false
      ask('Phone Number?') {|q| q.validate = /\A((\d{3})-|(\d{3}-))?\d{3}-\d{4}\Z/}
      print_seconds = true
      printer.run
    when "q"
      exit! 0
  end
end
