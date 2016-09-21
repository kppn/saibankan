# == Schema Information
#
# Table name: allocations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  number_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Allocation < ActiveRecord::Base
  belongs_to :user
  belongs_to :number, dependent: :destroy
end
