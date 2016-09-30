class ProjectValidator < ActiveModel::Validator
  def initialize(options)
    options[:class].class_eval do
      validates :name, presence: true
      validates :name, length: { in: 2..32 }
      validates :name, format: { with: /[a-zA-z0-9\-._~@!$&'()+,]/ } # URLパス使用可能文字(カスタム)
    end
    super
  end

  def validate(model)
  end
end

