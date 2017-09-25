module TableauRestApi
  module Helpers
    def self.camel_case_lower(term)
      term.split('_')
        .inject([]){ |buf,elm| buf.push(buf.empty? ? elm : elm.capitalize) }
        .join
    end
  end
end
