class Project < ActiveRecord::Base
  has_many :number_formats
  has_many :affiliations
  has_many :users, through: :affiliations
  has_many :numbers
  has_many :marks, as: :owner
end
