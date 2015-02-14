module Codeforces::Models

  class Problems < Base

    def grep(option)
      chain(base.select {|x| match?(option, x) })
    end

  end

end
