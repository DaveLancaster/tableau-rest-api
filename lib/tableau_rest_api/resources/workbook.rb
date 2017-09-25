module TableauRestApi
  class Workbook < Base
    attr_reader :id, :name, :content_url, :project 

    def initialize(workbook)
      @id = workbook.id
      @name = workbook.name
      @content_url = workbook.contentUrl
      @project = Project.new(workbook.project)
    end
  end
end
