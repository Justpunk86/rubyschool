require "spec_helper"

describe Article, type: :model do
  it { should have_many(:comments)}
end
  
