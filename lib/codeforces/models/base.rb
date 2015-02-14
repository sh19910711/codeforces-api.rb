module Codeforces::Models

  class Base

    attr_reader :client
    attr_reader :base

    def initialize(new_client, new_base)
      @client = new_client
      @base = new_base
    end

    def invert_grep(option)
      chain(base.select {|x| not_match?(option, x) })
    end

    def grep(option)
      chain(base.select {|x| match?(option, x) })
    end

    protected

    def chain(new_base)
      self.class.new(client, new_base)
    end

    def not_match?(option, target)
      option.all? do |key, value|
        ret = target.send(key)
        if ret.is_a?(Array)
          ret.all? {|item| not value === item }
        else
          not value === ret
        end
      end
    end

    def match?(option, target)
      option.all? do |key, value|
        ret = target.send(key)
        if ret.is_a?(Array)
          ret.any? {|item| value === item }
        else
          value === ret
        end
      end
    end

    def method_missing(method, *args, &block)
      base.send method, *args, &block
    end

    def respond_to?(method)
      base.respond_to?(method) || super
    end

  end

end

