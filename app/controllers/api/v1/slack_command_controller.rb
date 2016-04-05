module Api
  module V1
    ## METEO API PUBLIC API TO get informations about the Weather
    class SlackCommandController < ApplicationController
      respond_to :json

      def read_command
        result  = SlackCommand.handle_command(params)
        respond_to do |format|
          if result
            format.json { render :text => "Got it ! Command treated", :status => 200 }
          else
            format.json { render :text => "Error in the process", :status => 200 }
          end
        end
      end

    end
end
end
