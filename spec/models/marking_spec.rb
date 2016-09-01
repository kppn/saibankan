require 'rails_helper'

RSpec.describe Marking, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'associations' do
    it 'number' do
      expect{ Marking.new.build_number }.not_to raise_error
    end

    it 'mark' do
      expect{ Marking.new.build_mark }.not_to raise_error
    end
  end
end
