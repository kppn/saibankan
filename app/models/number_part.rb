class NumberPart < ActiveRecord::Base
  belongs_to :number_format

  attr_accessor :type

  def type
    read_attribute(:type)
  end
end
