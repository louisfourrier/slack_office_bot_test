class SlackMainBot < ActiveRecord::Base

  def self.command_managed
    return "Module has to set the command that they managed"
  end

  def self.all_commands
    command = command.to_s
    commands_managed = []
    self.descendants.each do |slack_module|
      commands_managed = commands_managed + slack_module.command_managed
    end
    return commands_managed
  end

  def self.search_module_for_command(command)
    command = command.to_s
    self.descendants.each do |slack_module|
      if slack_module.command_managed.include? command
        return slack_module
      end
    end
    # Default Module
    return self
  end

end
