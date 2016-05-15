module Lita
  module Handlers
    class ReplyHandler < Handler
      # insert handler code here
      @Day = %w(日 月 火 水 木 金 土)
      @Am_pm = { "AM" => "午前", "PM" => "午後" }

      route /今何時？/, :reply_clock, help: {"brian2: 今何時？" => "現在時刻を返してくれます"}

      def reply_clock( response )
          time = Time.now
          response.reply(time.to_s)
      end

      Lita.register_handler(self)
    end
  end
end
