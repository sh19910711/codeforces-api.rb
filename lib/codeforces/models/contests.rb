module Codeforces::Models

  class Contests < Base

    def grep(option)
      base.select do |contest|
        option.any? {|key, value| value === contest.send(key) }
      end
    end

  end

end

