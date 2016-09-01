class Marking < ActiveRecord::Base
  belongs_to :number
  has_one :mark
end
