# == Schema Information
#
# Table name: number_formats
#
#  id         :integer          not null, primary key
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NumberFormat < ActiveRecord::Base
  belongs_to :project
  has_many :number_parts, dependent: :destroy

  accepts_nested_attributes_for :number_parts

  def build binder
    number_parts.map{|np| np.build(binder)}.inject(&:+)
  end
end
