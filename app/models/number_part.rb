# == Schema Information
#
# Table name: number_parts
#
#  id               :integer          not null, primary key
#  type             :string
#  format           :string
#  number_format_id :integer
#  current          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

# NumberPart
#   STIの親クラス
#         NumberPart{format}  --+-- FixedPart
#                               +-- DatePart
#                               +-- SequentialPart{current}
#                               +-- RubyPart
#
#   注意
#     クラス設計
#       STIでは親クラスのモデルが全ての子クラスのカラムを持つ。子クラスはレコードを
#       持たず、親クラスのレコードの必要なカラムを利用する。
#       子クラスではtypeカラムに子クラス名が入り、Railsが読み込み時にその子クラスで
#       インスタンス化する。
#
#       saibankanの各NumberPartの更新は、STI type(クラス)の変更もサポートする。STIの
#       type(子クラス)を変更する事は本来禁じ手だが、これらレコードが他のモデルから
#       参照されており、作り直しだと関係するレコード更新となるため。
#     
#     type(クラス)変更
#       クラス変更はtypeカラムを変更しただけでは完全でない。
#         1. 単純にtypeアトリビュートの更新を試みてもRailsが受け付けない
#         2. レコードのtypeカラムを変えてもクラスは変わらない。
#       STIクラスを変えるには、次の方法を取る必要がある
#         1. Railsを介さずtypeカラムを変更する.
#             number_part.update_column(:type, 'FixedPart')
#               http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-update_column
#         2. クラスを変更する.
#             number_part.becomes!('FixedPart'.constantize)
#               http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-becomes
#
#     type(クラス)変更時
#       クラスが変わると、前のクラスで利用していたアトリビュート(カラム)は不要となる。
#       よって適切に初期化する必要がある(i.e. reset_sti / reset_sti_child_columns)
#       このクラス関係では、saveに伴い初期化される設計としている。
#       よって単純にカラムを変更したい場合、saveコールバックが走らない方法で更新する
#       必要がある(i.e. update_columns)
#

class NumberPart < ActiveRecord::Base
  belongs_to :number_format

  attr_accessor :type

  after_save :reset_sti_child_columns

  def build(binder)
    ''
  end

  def type
    read_attribute(:type)
  end

  def reset
    reset_sti
    reset_sti_child_columns
  end

  private
    # STIのtypeを消し親クラスに戻す。親クラスが持つアトリビュートを初期化する
    def reset_sti
      update_columns(format: '', type: nil)
    end

    # 子クラスのカラムを初期化する。各子クラスで適切にオーバーロードする事。
    def reset_sti_child_columns
      update_column(:current, nil)
    end
end
