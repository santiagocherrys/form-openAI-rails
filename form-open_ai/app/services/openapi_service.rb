require 'net/http'
require 'uri'
require 'json'

class OpenapiService
  
  def initialize(message)
    @message = message
    @api_url = "https://api.openai.com/v1/chat/completions"
    @apikey = ENV['APIKEY_OPENAI']

    #body structure
    @body = {
      "model": "gpt-4o-mini",
      "messages": [{"role": "user", "content": "#{@message}"}],
      "temperature": 0.7
    }

    puts "HEYY inicializo"
  end

  def askChat
    puts "PREGUNTO"
    retries ||= 0
    uri = URI(@api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    puts "esto es apikey #{@apikey}"
  
    request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' ,'Authorization' => "Bearer #{@apikey}" })
    request.body = @body.to_json
  
    begin
      response = http.request(request)
      response_body = JSON.parse(response.body)
      filterMessage =response_body["choices"]
      #filtered message is an array 
      message = filterMessage.first
      puts message["message"]["content"]

      if response.code.to_i == 201 || response_body['status'] == "OK"
        { success: true, data: response_body }
        
      else
        { success: false, error: response_body['error'] || 'Error desconocido' }
      end
    rescue StandardError => e
      if (retries += 1) <= 3
        retry
      else
        { success: false, error: "Error tras 3 reintentos: #{e.message}" }
      end
    end
  end
end