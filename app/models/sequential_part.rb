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
  def build(binder)
    num = format % current
    update_column :current, current+1
    num
  end

  def reset_sti_child_columns
    update_column(:current, 0)
  end
end
