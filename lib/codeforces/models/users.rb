module Codeforces::Models

  class Users < Base

    def grep(option)
      base.select do |user|
        option.any? {|key, value| value === user.send(key) }
      end
    end

  end

end

