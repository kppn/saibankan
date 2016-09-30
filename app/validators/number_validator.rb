class NumberValidator < ActiveModel::Validator
  def initialize(options)
    options[:class].class_eval do
      validates :val, :project_id, presence: true
    end
    super
  end

  def validate(model)
  end
end

