class BackgroundRepeater
  MIN_INTERVAL = 0.001

  def initialize(action, interval)
    raise "Nope" unless interval >= MIN_INTERVAL && action.is_a?(Proc)
    @is_running = false
    @thread = Thread.new do
      loop do
        Thread.stop unless @is_running
        action.call
        sleep interval
      end
    end
  end

  def start
    @is_running = true
    @thread.run
  end

  def stop
    @is_running = false
  end
end
