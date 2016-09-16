require 'rails_helper'

describe NumberDecorator do
  let(:number) { Number.new.extend NumberDecorator }
  subject { number }
  it { should be_a Number }
end
