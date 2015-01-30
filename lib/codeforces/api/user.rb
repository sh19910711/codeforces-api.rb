class Codeforces::Api

  class User

    attr_reader :client

    def initialize(base_client)
      @client = base_client
    end

    def info(handles, options = {})
      handles = [handles] unless handles.is_a?(Array)
      options[:query] ||= {}
      options[:query][:handles] = multi_values(handles)
      get("user.info", options)
    end

    def rated_list(options = {})
      get("user.ratedList", options)
    end

    def rating(handle, options = {})
      options[:query] ||= {}
      options[:query].merge! :handle => handle
      get("user.rating", options)
    end

    def status(handle, options = {})
      options[:query] ||= {}
      options[:query].merge! :handle => handle
      options[:query].merge! paginate(options[:offset])
      get("user.status", options)
    end

    private

    def method_missing(method, *args, &block)
      client.send method, *args, &block
    end

  end

end

