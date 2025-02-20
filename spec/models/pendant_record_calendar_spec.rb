# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PendantRecordCalendar, type: :model do
  subject { PendantRecordCalendar.new user: user, date: date }

  let(:user) { FactoryBot.create :user }
  let(:pendant) { FactoryBot.create :glass_art_piece, :wearable }
  let(:date) { Date.parse('2016-01-05') }

  it 'raises ArgumentError if not initialized with a User' do
    expect { PendantRecordCalendar.new date: Date.today }.to raise_error ArgumentError
  end

  it 'raises ArgumentError if not initialized with a date' do
    expect { PendantRecordCalendar.new user: user }.to raise_error ArgumentError
  end

  describe '#weeks' do
    it 'returns an array arrays each with exactly 7 days' do
      expect(subject.weeks.map(&:count).uniq).to eq [7]
    end

    it 'sets dates outside the date range as disabled' do
      expect(subject.weeks.first.first.date).to be < date
      expect(subject.weeks.first.first.disabled?).to eq true
    end
  end

  describe '#days' do
    let(:days_in_month) { date.end_of_month.day }
    let!(:pendant_record) { FactoryBot.create(:pendant_record, pendant: pendant, user: user, worn_on: Date.parse('2016-01-01')) }

    it 'returns a number of elements corresponding to the days in the month' do
      expect(subject.days.count).to eq days_in_month
    end

    it 'returns pendant records in the day they were recorded' do
      expect(subject.days.first.pendant_records).to contain_exactly pendant_record
      subject.days[1..subject.days.count].tap do |all_except_first_day|
        expect(all_except_first_day.all? { |day| day.pendant_records.empty? }).to eq true
      end
    end
  end

  describe '#month' do
    let(:date) { Date.parse('2016-01-05') }

    it 'returns a String representation of the month' do
      expect(subject.month).to eq 'January'
    end
  end

  describe '#year' do
    let(:date) { Date.parse('2016-01-05') }

    it 'returns a String representation of the year' do
      expect(subject.year).to eq '2016'
    end
  end
end
