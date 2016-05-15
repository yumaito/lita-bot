module Lita
  module Handlers
    class HttpHandle < Handler
      # insert handler code here
      http.get "/" do |request,response|
          response.body << "hello!"
      end

      Lita.register_handler(self)
    end
  end
end
