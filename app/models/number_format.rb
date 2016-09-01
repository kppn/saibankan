class NumberFormat < ActiveRecord::Base
  belongs_to :project
  has_many :number_parts

  accepts_nested_attributes_for :number_parts

  def build
    number_parts.map(&:build).inject(&:+)
  end

  def to_s
    number_parts.map(&:format).inject(&:+)
  end
end
