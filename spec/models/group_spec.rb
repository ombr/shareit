require 'spec_helper'

describe Group do
  it { should belong_to(:user) }
  it { should have_many(:users) }
  it { should have_many(:memberships) }
end
