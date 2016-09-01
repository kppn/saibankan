require 'rails_helper'

RSpec.describe Number, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'associations' do
    before do
      @number = Number.create({ val: 'a-b-c', project_id: 1})
      @mark = Mark.create({ label: 'mark01', description: 'mark 01 desc' })
    end

    it 'markings/mark' do
      expect{ Number.new.markings.build }.not_to raise_error
      expect{ Number.new.build_mark }.not_to raise_error
    end

    it 'users' do
      expect{ Number.new.users.build }.not_to raise_error
    end

    it 'project' do
      expect{ Number.new.build_project }.not_to raise_error
    end
  end
end
