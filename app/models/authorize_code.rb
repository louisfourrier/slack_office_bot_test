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

  def self.get_real_tokens(code)
    url = "https://slack.com/api/oauth.access"
    params = {client_id: "20872315939.32412953764", client_secret: "6dde81187129550643c323f9226fdc66", code: code }.to_json
    uri = URI.parse(url.to_s)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)
    response = http.request(request)
    puts response
  end
end
