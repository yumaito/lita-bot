module Lita
  module Handlers
    class ReplyHandler < Handler
      # insert handler code here
      @@Day   = %w(日 月 火 水 木 金 土)
      @@Am_pm = { "AM" => "午前", "PM" => "午後" }
      @@kao   = { hiso: "(*ﾟroﾟ)ﾋｿﾋｿ" }

      route /^time$/i, :reply_clock, help: {"brian2: time" => "現在時刻を返してくれます"}

      def reply_clock(response)
          time = Time.now
          day_of_week = @@Day[time.strftime("%w").to_i]
          am_pm = @@Am_pm[time.strftime("%p")]
          time_format_str = time.strftime("%Y年%m月%d日(#{day_of_week}) #{am_pm}%I時%M分%S秒")
          time_format_str = get_mention_name(response) + @@kao{:hiso} + "..." + time_format_str + "\n" + suffix_from_time(time)
          response.reply(time_format_str)
      end

      def get_mention_name(response)
        return response.user.metadata["mention_name"]
      end

      def suffix_from_time(time)
          hour = time.hour
          if hour.between?(0,4)
              return "寝ろよ"
          elsif hour.between?(5,7)
              return "早起きやな"
          elsif hour.between?(8,9)
              return "出勤？"
          elsif hour.between?(10,11)
              return "仕事してる？"
          elsif hour.between?(12,13)
              return "今日のお昼は何？"
          elsif hour.between?(14,18)
              return "仕事してる？"
          elsif hour.between?(19,20)
              return "日報書いた？"
          else
              return "おつかれさま"
          end
      end
      Lita.register_handler(self)
    end
  end
end
