require 'rails_helper'

describe ProjectValidator do
  before do
    DummyProject ||= Struct.new(:name, :description) do
      include ActiveModel::Validations
      validates_with ProjectValidator
    end
  end
  
  describe 'プロジェクト名' do
    let(:project) do
      project = DummyProject.new
      project.name = 'popa'
      project.description = 'popa desription'

      project
    end

    it 'nameあり, length範囲内, format正常' do
      expect(project.valid?).to be_truthy
    end

    it '使用可能記号' do
      expect((project.name += '$') && project.valid?).to be_truthy
      expect((project.name += '&') && project.valid?).to be_truthy
    end

    it 'nameなし' do
      expect(project.name = nil && project.valid?).to be_falsy
    end

    it 'name長さ過小(1文字)' do
      expect((project.name = 'f') && project.valid?).to be_falsy
    end

    it 'name長さ過大(33文字)' do
      expect((project.name = 'a' * 33) && project.valid?).to be_falsy
    end

    it 'format不正' do
      expect((project.name = 'brace_{is_invalid}' ) && project.valid?).to be_falsy
      expect((project.name = '日本語は不正'       ) && project.valid?).to be_falsy
      expect((project.name = 'space is invalid'   ) && project.valid?).to be_falsy
      expect((project.name = "\n_is_invalid"      ) && project.valid?).to be_falsy
    end
  end
end


