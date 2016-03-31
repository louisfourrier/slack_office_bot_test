module Api
  module V1

    ## METEO API PUBLIC API TO get informations about the Weather
    class PublicMeteoController < ApplicationController
      respond_to :json

      def get_weather
      end


    end
end
end
