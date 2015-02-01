module Codeforces::Helper

  def contest(query)
    if query.is_a?(Integer)
      contests.select {|c| query === c.id }.first
    else
      ret = contests.select {|c| query === c.name }
      raise "Error: contest is not found" if ret.empty?
      raise "Error: query is ambiguous" if ret.length > 1
      ret.first
    end
  end

  def contests
    api.contest.list
  end

  def each_contest
    contests.each {|contest| yield(contest) if block_given? }
  end

  def user(handle)
    create_user api.user.info(handle).first
  end

  def users
    create_users api.user.rated_list.map {|u| create_user u }
  end

  def recent_status
    api.problemset.recent_status.map {|s| create_submission s }
  end

  def each_status
    recent_status.each {|status| yield(status) if block_given? }
  end

end
