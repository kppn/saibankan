require 'rails_helper'

describe NumberDecorator do
  let(:number){ Number.new(created_at: Time.zone.local(2000, 1, 2, 3, 4, 5)) }

  describe 'デコレータ設定前' do
    it 'デコレーションメソッド呼び出し失敗' do
      expect {number.created_at_shorform}.to raise_error NoMethodError
    end
  end

  describe 'デコレータ設定後' do
    it 'デコレーションメソッド呼び出し成功' do
      number.extend NumberDecorator

      expect(number.created_at_shorform).to eq '2000-01-02 03:04'
    end
  end
end
