require "wit-ai/version"
require "wit-ai/client"

module WitAI
  def self.new_client(*params)
    Client.new(*params)
  end
end
