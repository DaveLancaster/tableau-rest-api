module TableauRestApi
  class Schedule < Base
    attr_reader :id, :name, :state, :priority 

    def initialize(schedule)
      @id = schedule.id
      @name = schedule.name
      @state = schedule.state
      @priority = schedule.priority
    end
  end
end
