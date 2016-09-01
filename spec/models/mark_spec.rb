require 'rails_helper'

RSpec.describe Mark, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  describe 'associations' do
    it 'marking' do
      expect{ Mark.new.build_marking }.not_to raise_error
    end

    it 'user' do
      expect{
        user = User.create({ email: 'test01@hoge.com', encrypted_password: 'aaa', sign_in_count: 1 })
        mark = Mark.new
        mark.owner = user
        mark.label = 'mark 01'
        mark.save
      }.not_to raise_error
    end

    it 'project' do
      expect{
        project = Project.create({ name: 'test01', description: 'test01' })
        mark = Mark.new
        mark.owner = project
        mark.label = 'mark 02'
        mark.save
      }.not_to raise_error
    end
  end
end
