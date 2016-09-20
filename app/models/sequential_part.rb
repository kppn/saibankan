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

class SequentialPart < NumberPart
  after_save :reset_current

  def build(binder)
    num = format % current
    increment! :current
    num
  end

  def reset_current
    update_column(:current, 0) unless self.current
  end
end
