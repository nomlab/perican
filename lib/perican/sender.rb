module Perican
  module Sender
    dir = File.dirname(__FILE__) + "/sender"

    autoload :Camome, "#{dir}/camome.rb"
  end
end
