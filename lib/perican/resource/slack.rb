require 'uri'
require 'net/https'
require 'json'

params = { 'token' => 'XXXXXXX',
           'channel' => 'XXXXXXX',
           'count' => 20 }

def slackChatGetMessage(params)
  return slackApi('channels.history', params)
end

def slackApi(method, params)
  url = 'https://slack.com/api/' + method
  headers = {  }
  return getRequest(url, params, headers)
end

def getRequest(url, params, headers = {  })
  uri = URI.parse(url)
  https = Net::HTTP.new(uri.host,uri.port)

  https.use_ssl = true

  request = Net::HTTP::Post.new(uri.path)
  request.set_form_data(params)
  res = https.request(request)
  return res
end

result = slackChatGetMessage(params)
object = JSON.parse(result.body)
object["messages"].each do |message|
  puts message["text"]
end
