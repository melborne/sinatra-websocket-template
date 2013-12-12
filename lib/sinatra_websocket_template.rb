%w(version cli).each do |lib|
  require "sinatra_websocket_template/#{lib}"
end

module SinatraWebsocketTemplate
  # Your code goes here...
end
