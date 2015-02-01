module Codeforces::Models

  class Base

    attr_reader :client
    attr_reader :base

    def initialize(new_client, new_base)
      @client = new_client
      @base = new_base
    end

    protected

    def method_missing(method, *args, &block)
      base.send method, *args, &block
    end

    def respond_to?(method)
      base.respond_to?(method) || super
    end

  end

end

