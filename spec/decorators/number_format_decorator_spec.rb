require 'rails_helper'

describe NumberFormatDecorator do
  let(:number_format) do
    number_format = NumberFormat.new(created_at: Time.zone.local(2000, 1, 2, 3, 4, 5))
    number_format.number_parts << FixedPart.new(format: 'fixed_')
    number_format.number_parts << DatePart.new(format: '%Y_')
    number_format.number_parts << SequentialPart.new(format: '%03d_', current: 10)
    number_format.number_parts << RubyPart.new(format: '3.to_s')
    number_format
  end

  describe 'デコレータ設定前' do
    it 'デコレーションメソッド呼び出し失敗' do
      expect {number_format.format}.to raise_error NoMethodError
    end
  end

  describe 'デコレータ設定後' do
    it 'デコレーションメソッド正常' do
      number_format.extend NumberFormatDecorator

      expect(number_format.format).to eq '[fixed_][%Y_][%03d_][3.to_s]'
    end
  end
end
