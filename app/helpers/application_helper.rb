module ApplicationHelper
  def format_datetime(datetime, format_type)
    day_name = %w[
      日
      月
      火
      水
      木
      金
      土
    ][datetime.wday]

    date_format = {
      short: '%H:%M',
      mid: "%m月%d日(#{day_name}) %H:%M",
      long: "%Y年%m月%d日(#{day_name}) %H:%M"
    }

    datetime.strftime(date_format[format_type])
  end

  def format_datetime_for_view(schedule_candidate)
    start_datetime, end_datetime =
      [[:start_datetime, :long], [:end_datetime, :short]].map do |attribute, format_type|
        format_datetime(schedule_candidate.public_send(attribute), format_type)
      end

    "#{start_datetime} 〜 #{end_datetime}"
  end

end
