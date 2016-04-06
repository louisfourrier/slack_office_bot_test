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
end
