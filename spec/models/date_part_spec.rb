# == Schema Information
#
# Table name: number_parts
#
#  id               :integer          not null, primary key
#  type             :string
#  format           :string
#  number_format_id :integer
#  current          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe DatePart, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  describe 'associations' do
    it 'number_format' do
      expect{ DatePart.new.build_number_format}.not_to raise_error
    end
  end
end
