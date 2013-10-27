require 'spec_helper'

describe User do
  it { should have_many(:posts) }
  it { should have_many(:items) }
  it { should have_many(:groups) }
end
