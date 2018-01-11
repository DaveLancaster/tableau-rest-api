module TableauRestApi
  module Pagination
    def complete?(response)
      pagination = response.pagination
      pagination ? paginate(pagination) : true
    end

    def paginate(pagination)
      read_pagination_header(pagination)
      return single_page? if first_page?
      @total % ((@page) * @per_page) == @total
    end

    def first_page?
      @page == 0
    end

    def single_page?
      @total <= @per_page 
    end

    def read_pagination_header(pagination)
      @page = pagination.pageNumber.to_i
      @per_page = pagination.pageSize.to_i
      @total = pagination.totalAvailable.to_i
    end
    
    def next_page
      @page + 1
    end
 
    def retrieve_additional_pages(response, collection, endpoint, extract)
      until complete?(response) do
        response = (get build_url(endpoint, next_page))
        collection = collection + extract.call(response)
      end
      collection
    end
  end
end
