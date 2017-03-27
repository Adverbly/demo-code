class BackgroundRepeater
  MIN_INTERVAL = 0.001

  def initialize(action, interval)
    raise 'Nope' unless interval >= MIN_INTERVAL && action.is_a?(Proc)
    @is_running = false
    @interval = interval
    @thread = Thread.new do
      loop do
        Thread.stop unless @is_running
        action.call # if action is known to be long-running, should kick off new thread for it
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
