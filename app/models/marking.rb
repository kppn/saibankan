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

class Marking < ActiveRecord::Base
  belongs_to :number
  belongs_to :mark
end
