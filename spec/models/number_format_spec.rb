require 'rails_helper'

RSpec.describe NumberFormat, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  describe 'associations' do
    it 'project' do
      expect{ NumberFormat.new.build_project }.not_to raise_error
    end
    it 'number_parts' do
      expect{ NumberFormat.new.number_parts.build }.not_to raise_error
    end
  end
end
