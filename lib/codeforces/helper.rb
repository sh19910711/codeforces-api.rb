module Codeforces::Helper

  def each_contest
    api.contest.list.each {|contest| yield(contest) if block_given? }
  end

  def user(handle)
    create_user api.user.info(handle).first
  end

  def each_status
    api.problemset.recent_status.map {|s| create_submission s }.each {|status| yield(status) if block_given? }
  end

end
