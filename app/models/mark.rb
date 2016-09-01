class Mark < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  belongs_to :marking
end
