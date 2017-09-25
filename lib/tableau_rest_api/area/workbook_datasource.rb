module TableauRestApi
  module WorkbookDatasource
    aspector do
      before :query_workbooks, :login
      before :get_workbook, :login
      before :datasources, :login
      before :get_datasource, :login
      before :update_workbook, :login
      before :update_datasource, :login
      before :update_project, :login
      before :query_projects, :login
      before :publish_workbook, :login
      before :publish_datasource, :login
      before :delete_workbook, :login
      before :delete_datasource, :login
    end

    def query_workbooks(site_id)
      url = build_url ['sites', site_id, 'workbooks']
      (get url).workbooks.workbook.to_a.map { |workbook| Workbook.new(workbook) }
    end

    def datasources(site_id)
      url = build_url ['sites', site_id, 'datasources']
      (get url).datasources.datasource.to_a.map { |ds| Datasource.new(ds) }
    end

    def get_workbook(site_id, workbook_id)
      url = build_url ['sites', site_id, 'workbooks', workbook_id, 'content']
      RestClient.get url, header
    end

    def get_datasource(site_id, datasource_id)
      url = build_url ['sites', site_id, 'datasources', datasource_id, 'content']
      RestClient.get url, header
    end

    def update_workbook(site_id, workbook_id, workbook)
      url = build_url ['sites', site_id, 'workbooks', workbook_id]
      Workbook.new((put url, workbook).workbook)
    end
    
    def update_datasource(site_id, datasource_id, datasource)
      url = build_url ['sites', site_id, 'datasources', datasource_id]
      Datasource.new((put url, datasource).datasource)
    end

    def update_project(site_id, project_id, project)
      url = build_url ['sites', site_id, 'projects', project_id]
      Project.new((put url, project).project)
    end

    def query_projects(site_id)
      url = build_url ['sites', site_id, 'projects']
      (get url).projects.project.to_a.map { |project| Project.new(project) }
    end

    def delete_workbook(site_id, workbook_id)
      url = build_url ['sites', site_id, 'workbooks', workbook_id]
      delete url
    end

    def delete_datasource(site_id, datasource_id)
      url = build_url ['sites', site_id, 'datasources', datasource_id]
      delete url
    end

    def delete_project(site_id, project_id)
      url = build_url ['sites', site_id, 'projects', project_id]
      delete url
    end

    def publish_workbook(site_id, metadata, payload)
      url = build_url ['sites', site_id, 'workbooks']
      boundary = SecureRandom.uuid
      request = Upload.new(metadata, payload, boundary).build
      Workbook.new((post url, request, boundary).workbook)
    end
    
    def publish_datasource(site_id, metadata, payload)
      url = build_url ['sites', site_id, 'datasources']
      boundary = SecureRandom.uuid
      request = Upload.new(metadata, payload, boundary).build(:datasource)
      Datasource.new((post url, request, boundary).datasource)
    end
  end
end
