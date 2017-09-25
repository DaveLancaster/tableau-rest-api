module TableauRestApi
  class Project < Base
    attr_reader :id, :name, :description, :content_permissions 

    def initialize(project)
      @id = project.id
      @name = project.name
      @description = project.description
      @content_permissions = project.contentPermissions
    end
  end
end
