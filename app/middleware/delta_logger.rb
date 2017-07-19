class DeltaLogger
  def initialize(application)
    @application = application
  end

  def call(environment)
    dup._call environment
  end

  def _call(environment)
    request_started_on = Time.now
    @status, @headers, @response = @application.call(environment)
    request_ended_on = Time.now
    log_file("Request took #{request_ended_on - request_started_on} seconds.")
    [@status, @headers, @response]
  end

  private

  def log_file(message)
    middleware_log = "[#{Time.now}]: #{message}\n"
    File.write('log/middleware.log', middleware_log, mode: 'a+')
  end
end
