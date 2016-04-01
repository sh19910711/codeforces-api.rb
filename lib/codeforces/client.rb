require "sawyer"
require "logger"
require "uri"
require "addressable/uri"
require "time"
require "digest/sha2"
require "codeforces/api"
require "codeforces/client"
require "codeforces/helper"
require "codeforces/models"

class Codeforces::Client

  include Codeforces::Helper

  DEFAULT_ENDPOINT   = "http://codeforces.com/api/"
  DEFAULT_PAGE_COUNT = 50
  DEFAULT_API_KEY    = ENV["CODEFORCES_API_KEY"]
  DEFAULT_API_SECRET = ENV["CODEFORCES_API_SECRET"]

  attr_reader :endpoint
  attr_reader :api_key
  attr_reader :api_secret

  def initialize(options = {})
    @endpoint = options.fetch(:endpoint, DEFAULT_ENDPOINT)
    @api_key = options.fetch(:api_key, DEFAULT_API_KEY)
    @api_secret = options.fetch(:api_secret, DEFAULT_API_SECRET)
  end

  def logger
    @logger ||= new_logger
  end

  def agent
    @agent ||= ::Sawyer::Agent.new(DEFAULT_ENDPOINT)
  end

  def last_response
    @last_response
  end

  def get(path, options = {})
    request(:get, path, options).result
  end

  def post(path, options = {})
    request(:post, path, options).result
  end

  def request(method, path, options = {})
    request_uri = ::Addressable::URI.new
    query = {}
    query.merge!(options[:query]) unless options[:query].nil?
    request_uri.query_values = query

    enable_auth!(path, request_uri, query) unless method === :post || api_key.nil?

    path += "?#{request_uri.query}" unless request_uri.query.empty?

    logger.debug "#{method.upcase} #{::URI.join endpoint, path} with #{options[:data]}"
    @last_response = agent.call(method, path, :query => options[:data])

    raise_http_status last_response
    raise_codeforces_status last_response
    last_response.data
  end

  def raise_http_status(res)
    logger.debug "HTTP: #{res.status}"
    unless res.status === 200
      raise "Error: HTTP Status is #{res.status}"
    end
  end

  def raise_codeforces_status(res)
    logger.debug "Codeforces: #{res.data[:status]}"
    unless res.data.status === "OK"
      raise "Error: #{res.data[:status]} #{res.data[:comment]}"
    end
  end

  def paginate(offset)
    offset = 0 if offset.nil?
    result = {
      :from => DEFAULT_PAGE_COUNT * offset + 1,
      :count => DEFAULT_PAGE_COUNT,
    }
  end

  def multi_values(values)
    values.join ";"
  end

  def api
    @api ||= ::Codeforces::Api.new(self)
  end

  def create_user(user)
    ::Codeforces::Models::User.new self, user
  end

  def create_submission(status)
    ::Codeforces::Models::Submission.new self, status
  end

  def create_users(users)
    ::Codeforces::Models::Users.new self, users
  end

  def create_contest(contest)
    ::Codeforces::Models::Contest.new self, contest
  end

  def create_contests(contests)
    ::Codeforces::Models::Contests.new self, contests
  end

  def create_problem(problem)
    ::Codeforces::Models::Problem.new self, problem
  end

  def create_problems(problems)
    ::Codeforces::Models::Problems.new self, problems
  end

  private

  def new_logger
    logger = ::Logger.new(STDOUT)
    logger.level = ::Logger::INFO
    logger
  end

  def enable_auth!(path, request_uri, query)
    query.merge!({:time => server_time})
    query.merge!({:apiKey => api_key})
    request_uri.query_values = query

    # calc signature
    seed = api_sig_seed(654321, path, request_uri)
    hash = ::Digest::SHA512.hexdigest(seed)
    query.merge!({:apiSig => "654321#{hash}"})
    request_uri.query_values = query

    logger.debug "Enable Auth"
    logger.debug "API signature seed: #{seed}"
  end

  def is_old_time?(t)
    t.nil? || ::Time.now.to_i - t > 30
  end

  def server_time
    return @server_time unless is_old_time?(@server_time)

    logger.debug "Resolve Server Time"
    @server_time = ::Net::HTTP.start("codeforces.com", 80) do |http|
      ::Time.parse(http.head("/")["date"]).to_i
    end
  end

  def api_sig_seed(rand, path, uri)
    "#{rand}/#{path}?#{uri.query}##{api_secret}"
  end

end

