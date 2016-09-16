module NumberDecorator
  def created_at_shorform
    created_at.strftime '%F %H:%M'
  end
end
