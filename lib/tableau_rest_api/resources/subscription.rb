module TableauRestApi
  class Subscription < Base
    attr_reader :id, :subject 

    def initialize(sub)
      @id = sub.id
      @subject = sub.subject
    end
  end
end
