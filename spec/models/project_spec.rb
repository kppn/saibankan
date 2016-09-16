# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Project, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'associations' do
    it 'number_formats' do
      expect{ Project.new.number_formats.build }.not_to raise_error
    end
    it 'number' do
      expect{ Project.new.numbers.build }.not_to raise_error
    end
    it 'mark' do
      expect{ Project.new.marks.build }.not_to raise_error
    end
    it 'user' do
      expect{ Project.new.affiliations.build }.not_to raise_error
      expect{ Project.new.users.build }.not_to raise_error
    end
  end
end
