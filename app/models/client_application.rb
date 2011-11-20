require 'oauth'

class ClientApplication
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String
  field :key, :type => String
  field :secret, :type => String

  before_create :generate_keys

  validates :name, :presence => true,
    :length => {:minimum => 2}

  attr_accessible :name, :description
  protected
    
    def generate_keys
      self.key = OAuth::Helper.generate_key(40)[0,40]
      self.secret = OAuth::Helper.generate_key(40)[0,40]
    end
end
