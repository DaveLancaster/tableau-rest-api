module TableauRestApi
  # Representation of a x_auth_tableau token
  # These tokens have a finite lifespan, the default is 4 hours.
  class Token
    attr_reader :value, :expires

    def initialize(token, duration)
      @value = token
      @expires = duration.from_now
    end

    def expired?
      @value ? Time.now > @expires : true
    end
  end
end
