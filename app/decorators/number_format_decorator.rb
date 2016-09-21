module NumberFormatDecorator
  def format
    number_parts.map(&:format).select(&:present?).map{|f| "[#{f}]"}.join
  end
end
