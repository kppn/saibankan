class NumberFormatValidator < ActiveModel::Validator
  def initialize(options)
    options[:class].class_eval do
      validates :project_id, presence: true
    end
    super
  end

  def validate(model)
  end
end

