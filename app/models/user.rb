class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :affiliations
  has_many :projects, through: :affiliations
  has_many :allocations
  has_many :numbers, through: :allocations
  has_many :marks, as: :owner
end
