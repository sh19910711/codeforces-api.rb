module Codeforces::Models

  class Contests < Base

    def div1
      invert_grep(:name => /Div[\.]? 2/)
    end

    def div2
      grep(:name => /Div[\.]? 2/)
    end

    def rounds
      grep(:name => /^Codeforces( Alpha| Beta|) Round/)
    end

    def invert_grep(option)
      chain(base.select {|x| not_match?(option, x) })
    end

    def grep(option)
      chain(base.select {|x| match?(option, x) })
    end

  end

end

