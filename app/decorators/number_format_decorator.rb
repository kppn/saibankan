module NumberFormatDecorator
  def format
    number_parts.map(&:format).inject(&:+)
  end
end
