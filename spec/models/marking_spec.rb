# == Schema Information
#
# Table name: markings
#
#  id         :integer          not null, primary key
#  number_id  :integer
#  mark_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
