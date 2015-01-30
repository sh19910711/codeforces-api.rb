module Codeforces; end
require "codeforces/client"
require "codeforces/version"

module Codeforces

  class << self

    def client
      @client ||= Client.new
    end

    private

    def method_missing(method, *args, &block)
      super unless client.respond_to?(method)
      client.send method, *args, &block
    end

  end

end

