module Api
  module V1
    ## METEO API PUBLIC API TO get informations about the Weather
    class SlackCommandController < ApplicationController
      respond_to :json

      def read_command
        SlackCommand.handle_command(params)
        respond_to do |format|
          format.all { render :nothing => true, :status => 200 }
        end
      end

    end
end
end
