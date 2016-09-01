require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  describe 'associations' do
    it 'project' do
      expect{ User.new.affiliations.build }.not_to raise_error
      expect{ User.new.projects.build }.not_to raise_error
    end
  end
end
