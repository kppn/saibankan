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

class NumberPart < ActiveRecord::Base
  belongs_to :number_format

  attr_accessor :type

  def build
    ''
  end

  def type
    read_attribute(:type)
  end
end
