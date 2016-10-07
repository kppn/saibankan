# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ActiveRecord::Base
  has_many :number_formats, dependent: :destroy
  has_many :affiliations, dependent: :destroy
  has_many :users, through: :affiliations
  has_many :numbers, dependent: :destroy
  has_many :marks, as: :owner, dependent: :destroy
  accepts_nested_attributes_for :marks

  validates_with ProjectValidator

end
