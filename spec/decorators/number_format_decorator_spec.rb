require 'rails_helper'

describe NumberFormatDecorator do
  let(:number_format) { NumberFormat.new.extend NumberFormatDecorator }
  subject { number_format }
  it { should be_a NumberFormat }
end
