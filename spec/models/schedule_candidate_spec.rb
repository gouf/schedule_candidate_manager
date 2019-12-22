describe ScheduleCandidate do
  describe 'Tests attributes' do
    subject { ScheduleCandidate.new }

    it { is_expected.to respond_to(:schedule_id) }
    it { is_expected.to respond_to(:calendar_event_id) }
    it { is_expected.to respond_to(:start_datetime) }
    it { is_expected.to respond_to(:end_datetime) }
    it { is_expected.to respond_to(:token) }
  end

  describe 'after_create' do
    before { create(:schedule) }

    let(:calendar_event_id) { 'foobar' }
    let(:schedule) { Schedule.first }

    context '#insert_to_calendar' do
      # 候補日の保存時に、併せて Google Calendar にイベントを保存
      it 'also save Google Calendar Event Id' do
        # ScheduleCandidate#insert_event 中で:
        #   GoogleCalendar#insert_event 呼び出し後メソッドチェーンで返り値からの id を読み取る
        expect_any_instance_of(GoogleCalendar).to receive(:insert_event).and_return(Struct.new(:id, keyword_init: true).new(id: calendar_event_id))

        schedule_candidate =
          ScheduleCandidate.new(
            schedule_id: schedule.id,
            start_datetime: DateTime.current,
            end_datetime: DateTime.current
          )
        schedule_candidate.save!

        expect(schedule_candidate.calendar_event_id).to eq calendar_event_id
      end
    end

    after { Schedule.destroy_all }
  end
end
