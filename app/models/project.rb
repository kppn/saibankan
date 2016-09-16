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
  has_many :number_formats
  has_many :affiliations
  has_many :users, through: :affiliations
  has_many :numbers
  has_many :marks, as: :owner
  accepts_nested_attributes_for :marks

  validates :name, presence: true
end
