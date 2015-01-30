class Codeforces::Api

  class Contest

    attr_reader :client

    def initialize(base_client)
      @client = base_client
    end

    def hacks(contest_id, options = {})
      options[:query] ||= {}
      options[:query].merge! :contestId => contest_id
      get("contest.hacks", options)
    end

    def list(options = {})
      get("contest.list", options)
    end

    def standings(contest_id, options = {})
      options[:query] ||= {}
      options[:query].merge! :contestId => contest_id
      options[:query].merge! paginate(options[:offset])
      get("contest.standings", options).rows
    end

    def status(contest_id, options = {})
      options[:query] ||= {}
      options[:query].merge! :contestId => contest_id
      options[:query].merge! paginate(options[:offset])
      get("contest.status", options)
    end

    private

    def method_missing(method, *args, &block)
      client.send method, *args, &block
    end

  end

end

