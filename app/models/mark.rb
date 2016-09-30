# == Schema Information
#
# Table name: marks
#
#  id          :integer          not null, primary key
#  owner_id    :integer
#  owner_type  :string
#  label       :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Mark < ActiveRecord::Base
  has_many :markings
  has_many :numbers, through: :markings

  belongs_to :owner, polymorphic: true

  validates_with MarkValidator
end
