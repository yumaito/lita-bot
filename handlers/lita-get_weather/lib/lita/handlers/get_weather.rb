module Lita
  module Handlers
    class GetWeather < Handler
      # insert handler code here
      @@API = ENV['OPEN_WEATHER_API_KEY']


      route /天気/, :weather, help: {"brian2: 天気" => "天気を教えてくれます"}

      def weather(response)
        key = 'http://api.openweathermap.org/data/2.5/weather?q=Tokyo&appid=b108411c925b3f19909bfb7bb3a7103e'
        uri = URI.parse(key)
        data = http.get(uri)
        result  = MultiJson.load(data.body)
        # 表示に必要な情報を整形
        name = result["name"]
        desc= result["weather"][0]["description"].gsub(/(\s)/,'_')
        desc_jp = t("weather_code.#{desc}")
        #
        replyStr = "#{name}の天気は#{desc_jp}"
        response.reply(replyStr)
      end
      Lita.register_handler(self)
    end
  end
end
