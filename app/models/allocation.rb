class Allocation < ActiveRecord::Base
  belongs_to :user
  belongs_to :number
end
