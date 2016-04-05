class MeteoBot < SlackMainBot

  def self.command_managed
    return ["meteo", "weather"]
  end

end
