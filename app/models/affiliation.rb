# == Schema Information
#
# Table name: affiliations
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  user_id       :integer
#  administrator :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Affiliation < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
end
