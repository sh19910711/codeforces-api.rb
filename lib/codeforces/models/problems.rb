module Codeforces::Models

  class Problems < Base

    def initialize(new_client, new_base)
      super new_client, new_base
      @contest = {}
      new_base.each do |problem|
        @contest[problem.contestId] ||= []
        @contest[problem.contestId].push problem
      end
    end

    def contest(id)
      @contest[id] ||= []
      self.class.new client, @contest[id]
    end

    def grep(option)
      chain(base.select {|x| match?(option, x) })
    end

  end

end
