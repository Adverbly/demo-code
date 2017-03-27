class BackgroundRepeater
  MIN_INTERVAL = 0.001

  def initialize(interval)
    raise 'Nope' unless interval >= MIN_INTERVAL
    @is_running = false
    @interval = interval
    @thread = Thread.new do
      loop do
        Thread.stop unless @is_running
        yield
        wait_for_next_start
      end
    end
  end

  def wait_for_next_start
    @runs += 1
    sleep_interval = @start_time + @runs * @interval - Time.now
    sleep sleep_interval
  end

  def start
    @is_running = true
    @start_time = Time.now
    @runs = 0
    @thread.run
  end

  def stop
    @is_running = false
  end
end
