describe Schedule do
  describe 'Tests attributes' do
    subject { Schedule.new }

    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:location) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:schedule_candidates) }
  end

  describe 'Create children record' do
    before do
      schedule =
        Schedule.new(
          title: 'foo',
          corporation_name: 'bar',
          location: 'Yokohama Sta.',
          description: 'foo bar brabra...'
        )
      schedule.save

      schedule_candidate =
        ScheduleCandidate.new(
          schedule_id: schedule.id,
          start_datetime: Date.today.to_datetime,
          end_datetime: Date.today.to_datetime.advance(hours: 1)
        )
      schedule_candidate.save
    end

    it 'can be found candidates from Schedule' do
      schedule = Schedule.first

      expect(schedule.schedule_candidates.size).to eq 1
    end

    after do
      Schedule.destroy_all
      ScheduleCandidate.destroy_all
    end
  end
end
