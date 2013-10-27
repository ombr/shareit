require 'spec_helper'

describe Group do
  it { should belong_to(:user) }
end
