class InstallationController < ApplicationController
  def help
  end

  def support
  end

  def authorize
    AuthorizeCode.create(code: params)
    puts params
  end

  def authorize_process
    AuthorizeCode.create(code: params)
    puts params
  end
end
