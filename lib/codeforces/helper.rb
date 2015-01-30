module Codeforces::Helper

  def each_contest
    api.contest.list.each {|contest| yield(contest) if block_given? }
  end

  def user(handle)
    api.user.info(handle).first
  end

  def each_status
    api.problemset.recent_status.map {|status| submission status }.each {|status| yield(status) if block_given? }
  end

end
