module Lita
  module Handlers
    class GetWeather < Handler
      # insert handler code here
      @@Weather_API = ENV['OPEN_WEATHER_API_KEY']
      @@Google_API = ENV['GOOGLE_MAP_API_KEY']

      route /天気[\s|\p{blank}](.+)/, :weather, help: {"brian2: 天気　「都市名」" => "天気を教えてくれます。（スペースは半角でも全角でも可）"}

      def weather(response)
        city_name = response.matches[0][0]

        city_name_en = detect_city_name(city_name)

        key = 'http://api.openweathermap.org/data/2.5/weather?q='+city_name_en+'&appid='+ @@Weather_API
        uri = URI.parse(key)
        data = http.get(uri)
        result  = MultiJson.load(data.body)
        #

        # 表示に必要な情報を整形
        desc= result["weather"][0]["description"].gsub(/(\s)/,'_')
        desc_jp = t("weather_code.#{desc}")
        #
        replyStr = "#{city_name}の天気は#{desc_jp}"
        response.reply(replyStr)
      end
      #  日本語都市名から英語都市名に変換（google maps api経由） 
      def detect_city_name(city_name)
          address = 'https://maps.googleapis.com/maps/api/geocode/json?address='+city_name+'&key='+ @@Google_API
          address_uri = URI.escape(address)
          address_data = http.get(address_uri)
          address_result = MultiJson.load(address_data.body)
          city_name_en = address_result["results"][0]["address_components"][0]["long_name"]
          return city_name_en
      end

      Lita.register_handler(self)
    end
  end
end
