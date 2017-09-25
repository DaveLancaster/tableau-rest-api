module TableauRestApi
  class Upload
    def initialize(metadata, payload, boundary)
      @metadata = metadata
      @payload = payload
      @boundary = boundary
    end

    def build(obj=:workbook)
      <<-END
        --#{@boundary}\r
        Content-Disposition: name="request_payload"\r
        Content-Type: text/xml\r
        \r
        <tsRequest>\r
          <#{obj} name="#{@metadata[:name]}">\r
            <project id="#{@metadata[:project]}"/>\r
          </#{obj}>\r
        </tsRequest>\r
        --#{@boundary}\r
        Content-Disposition: name="tableau_#{obj}"; filename="#{@payload[:filename]}"\r
        Content-Type: application/octet-stream\r
        \r
        #{@payload[:data]}\r
        --#{@boundary}--\r
      END
    end
  end
end
