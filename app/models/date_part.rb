class DatePart < NumberPart
  def build
    Time.zone.now.strftime format
  end
end
