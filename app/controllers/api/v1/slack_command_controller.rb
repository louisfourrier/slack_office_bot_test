module Api
  module V1
    ## METEO API PUBLIC API TO get informations about the Weather
    class SlackCommandController < ApplicationController
      respond_to :json

      def read_command
        SlackCommand.handle_command(params)
      end

    end
end
end
