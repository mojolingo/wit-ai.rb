require 'faraday'
require 'faraday_middleware'

module WitAI
  class Client
    BASE_URL = 'https://api.wit.ai'

    def initialize(api_key)
      @api_key = api_key
      @conn = Faraday.new url: BASE_URL do |c|
        c.adapter :net_http
        c.response :logger
        c.use FaradayMiddleware::ParseJson, content_type: 'application/json'
        c.response :raise_error
      end
    end

    def interpret(message)
      @conn.get '/message' do |req|
        req.params['q'] = message
        req.headers['Authorization'] = "Bearer #{@api_key}"
      end.body
    end

    def recognize(file_path, format: raise(ArgumentError, 'Must specify a format'))
      @conn.post '/speech' do |req|
        req.headers['Authorization'] = "Bearer #{@api_key}"
        req.headers['Content-Type'] = format
        req.body = File.read(file_path)
      end.body
    end
  end
end
