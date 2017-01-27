require 'spec_helper'

describe SearchType do

  let(:klass) { SearchType.new(params) }

  let(:date)          { '2016-10-10' }
  let(:retailer_id )  { 314 }
  let(:lat)           { 1.81 }
  let(:long)          { 1.91 }
  let(:radius)        { 5 }

  let(:params) { { retailer_id: retailer_id } }

  describe '.SearchType' do
    subject { klass }
    it { should be_kind_of(SearchType) }  # .new returns self

    describe 'sad path' do
      subject { lambda { klass } }
      context 'when params are nil' do
        let(:params) { nil }
        it { should raise_error(StandardError) }
      end

      context 'when params are empty' do
        let(:params) { { } }
        it { should raise_error(StandardError) }
      end
    end
  end

  subject { klass.type }

  describe 'happy path' do
    context 'when searching by retailer_id' do
      it { should be(:retailer) }
    end

    context 'when searching by retailer_id and date' do
      let(:params) { { retailer_id: retailer_id, date: date } }
      it { should be(:retailer_and_date) }
    end

    context 'when searching by lat, long, and radius' do
      let(:params) { { lat: lat, long: long, radius: radius } }
      it { should be(:location) }
    end
  end

  describe 'sad path' do
    subject { lambda { klass.type } }

    describe 'when missing required params' do
      context 'missing lat' do
        let(:params) { { long: long, radius: radius } }
        it { should raise_error(StandardError) }
      end

      context 'missing long' do
        let(:params) { { lat: lat, radius: radius } }
        it { should raise_error(StandardError) }
      end

      context 'missing radius' do
        let(:params) { { lat: lat, long: long } }
        it { should raise_error(StandardError) }
      end
    end

    describe 'when required params are empty strings' do
      context 'lat is empty' do
        let(:params) { { lat: '', long: long, radius: radius } }
        it { should raise_error(StandardError) }
      end

      context 'long is empty' do
        let(:params) { { lat: lat, long: '', radius: radius } }
        it { should raise_error(StandardError) }
      end

      context 'radius is empty' do
        let(:params) { { lat: lat, long: long, radius: '' } }
        it { should raise_error(StandardError) }
      end
    end

  end


end