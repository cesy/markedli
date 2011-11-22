class AccessGrant
  include Mongoid::Document
  belongs_to :user
  belongs_to :client_application
end
