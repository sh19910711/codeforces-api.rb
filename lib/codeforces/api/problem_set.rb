class Codeforces::Api

  class ProblemSet

    attr_reader :client

    def initialize(base_client)
      @client = base_client
    end

    def problems(options = {})
      options[:query] ||= {}
      options[:query][:tags] = multi_values(options[:query][:tags]) unless options[:query][:tags].nil?
      get("problemset.problems", options).problems
    end

    def problem_statistics(options = {})
      options[:query] ||= {}
      options[:query][:tags] = multi_values(options[:query][:tags]) unless options[:query][:tags].nil?
      get("problemset.problems", options).problemStatistics
    end

    def recent_status(options = {})
      options[:query] ||= {}
      options[:query].merge! paginate(0)
      get("problemset.recentStatus", options)
    end

    private

    def method_missing(method, *args, &block)
      client.send method, *args, &block
    end

  end

end

