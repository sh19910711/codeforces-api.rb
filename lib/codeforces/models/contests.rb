module Codeforces::Models

  class Contests < Base

    def rounds
      grep(:name => /^Codeforces( Alpha| Beta|) Round/)
    end

    def grep(option)
      chain(base.select {|x| match?(option, x) })
    end

  end

end

