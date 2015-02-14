module Codeforces::Models

  class Problems < Base

    def grep(option)
      base.select {|p| match?(option, p) }
    end

  end

end
