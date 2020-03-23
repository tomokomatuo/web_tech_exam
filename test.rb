require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '/',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('/exam', WEBrick::HTTPServlet::ERBHandler, "exam.html.erb")
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.mount('/quality.cgi', WEBrick::HTTPServlet::CGIHandler, 'quality.rb')
server.mount('', WEBrick::HTTPServlet::ERBHandler, 'exam.html.erb')
server.start