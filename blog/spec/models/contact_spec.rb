#contact_spec.rb
require "spec_helper"

describe Contact, type: :model do
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:message)}
end
  