require "codeforces/api/contest"
require "codeforces/api/problem_set"
require "codeforces/api/user"

class Codeforces::Api

  attr_reader :client

  def initialize(new_client)
    @client = new_client
  end

  def contest
    @contest ||= ::Codeforces::Api::Contest.new(client)
  end

  def problemset
    @problem_set ||= ::Codeforces::Api::ProblemSet.new(client)
  end

  def user
    @user ||= ::Codeforces::Api::User.new(client)
  end

end
