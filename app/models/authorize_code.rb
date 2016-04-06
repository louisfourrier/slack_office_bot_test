# == Schema Information
#
# Table name: authorize_codes
#
#  id         :integer          not null, primary key
#  code       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AuthorizeCode < ActiveRecord::Base
  validates :code, presence: true
  require 'net/http'
  require 'open-uri'
  require 'uri'

  def self.get_real_tokens(code)
    url = "https://slack.com/api/oauth.access"
    params = { "client_id" => "20872315939.32412953764", "client_secret" => "6dde81187129550643c323f9226fdc66", "code" => code.to_s }
    uri = URI.parse(url.to_s)
    uri.query = URI.encode_www_form( params )
    response =  Net::HTTP.get(uri)
    self.create(code: response)
    puts response
  end
end
