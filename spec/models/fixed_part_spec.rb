require 'rails_helper'

RSpec.describe FixedPart, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  describe 'associations' do
    it 'number_format' do
      expect{ FixedPart.new.build_number_format}.not_to raise_error
    end
  end
end