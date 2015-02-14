module Codeforces::Models

  class Users < Base

    def grep(option)
      chain(base.select {|x| match?(option, x) })
    end

  end

end

