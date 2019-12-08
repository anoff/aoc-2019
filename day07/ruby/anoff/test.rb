require_relative './computer'

def repeat_every(interval)
  Thread.new do
    loop do
      start_time = Time.now
      yield
      elapsed = Time.now - start_time
      sleep([interval - elapsed, 0].max)
    end
  end
end

puts "Starting computer"
c = Computer.new("3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0")
# c.stdin.puts
begin
  # Do stuff with the output here. Just printing to show it works
  t = Thread.new do
    c.stdout.each { |line|
      p line
      if line.include?("Please provide numeric input:")
        c.stdin.puts 23
      end
    }
  end
rescue Errno::EIO
  raise "Error: Errno:EIO error"
end

thread = repeat_every(0.1) do
  puts c.terminated?
  puts Time.now.to_i
end
puts "Doing other stuff..."
thread.join