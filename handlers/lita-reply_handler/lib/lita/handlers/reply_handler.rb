module Lita
  module Handlers
    class ReplyHandler < Handler
      # insert handler code here
      @@Day = %w(日 月 火 水 木 金 土)
      @@Am_pm = { "AM" => "午前", "PM" => "午後" }

      route /今何時？/, :reply_clock, help: {"brian2: 今何時？" => "現在時刻を返してくれます"}

      def reply_clock( response )
          time = Time.now
          day_of_week = @@Day[time.strftime("%w").to_i]
          am_pm = @@Am_pm[time.strftime("%p")]
          time_format_str = time.strftime("%Y年%m月%d日（#{day_of_week}） #{am_pm}%I時%M分%S秒")
          time_format_str = "つ " + time_format_str
          response.reply(time_format_str)
      end

      Lita.register_handler(self)
    end
  end
end
