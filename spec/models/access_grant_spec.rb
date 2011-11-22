require 'spec_helper'

describe AccessGrant do
  it { should belong_to :client_application }
  it { should belong_to :user }
end
