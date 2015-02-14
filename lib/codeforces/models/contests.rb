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

  end

end

