class MarkValidator < ActiveModel::Validator
  def initialize(options)
    options[:class].class_eval do
      validates :label, presence: true
    end
    super
  end

  def validate(model)
  end
end

