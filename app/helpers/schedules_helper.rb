module SchedulesHelper
  # Ref: https://stackoverflow.com/questions/1300838/how-to-convert-an-address-into-a-google-maps-link-not-map
  def google_maps_location_search_link(query)
    return if query.blank?

    link_to(
      query,
      "https://www.google.com/maps/search/?api=1&query=#{URI.encode(query)}",
      target: '_blank',
      rel: 'noopener noreferrer',
      title: 'Google Map で表示'
    )
  end
  def list_schedule_candidates(candidates)
    li_style = 'text-align: right; list-style: none;'

    is_same_year =
      lambda do |candidate_a, candidate_b|
        candidate_a.year.eql?(candidate_b.year)
      end

    tag.ul do
      candidates.map.with_index do |candidate, index|
        link_title = format_datetime_for_view(candidate)
        next concat(tag.li(tag.a(link_title, href: edit_schedule_candidate_path(candidate.id)), style: li_style)) if index.zero?

        # 年数に変化があれば 年数も含めて開始日時を表示
        # 変化がなければ年数を省略して開始日時を表示 (月, 日のみ)
        date_format_type =
          if is_same_year.call(*[index, index.pred].map { |i| candidates[i].start_datetime })
            :mid
          else
            :long
          end

        # 表示形式をフォーマットした値を代入
        start_datetime, end_datetime =
          [[:start_datetime, date_format_type], [:end_datetime, :short]].map do |attribute, format_type|
            format_datetime(candidate.public_send(attribute), format_type)
          end

        link_title = "#{start_datetime} 〜 #{end_datetime}"
        concat tag.li(tag.a(link_title, href: edit_schedule_candidate_path(candidate.id)), style: li_style)
      end
    end
  end
end
