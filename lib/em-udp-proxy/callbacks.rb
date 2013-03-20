module UDPProxy
  module Callbacks

    def callbacks
      @callbacks ||= Hash.new{|h,k| h[k] = [] }
    end

    def add_callback(name, c=nil, &b)
      c ||= b
      callbacks[name.to_s] << c
    end
    alias on add_callback

    def run_callbacks(name, *a, &b)
      callbacks[name.to_s].each do |c|
        c.call(*a, &b)
      end
    end

  end
end
