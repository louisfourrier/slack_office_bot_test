class InstallationController < ApplicationController
  def help
  end

  def support
  end

  def authorize
    AuthorizeCode.create(code: params)
    if params[:code]
      AuthorizeCode.get_real_tokens(params[:code].to_s)
    end
    puts params
  end

  def authorize_process
    AuthorizeCode.create(code: params)
    puts params
  end
end
