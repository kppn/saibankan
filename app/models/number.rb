class Number < ActiveRecord::Base
  belongs_to :project
  has_many :allocations
  has_many :users, through: :allocations
  has_many :markings
  has_many :marks, through: :markings
end
