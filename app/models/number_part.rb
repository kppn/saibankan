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

  after_save :reset_sti_child_columns

  def build(binder)
    ''
  end

  def type
    read_attribute(:type)
  end

  def reset
    reset_sti
    reset_sti_child_columns
  end

  private
    def reset_sti
      update_columns(format: '', type: nil)
    end

    def reset_sti_child_columns
      update_column(:current, nil)
    end
end
