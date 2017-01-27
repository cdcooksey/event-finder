require 'spec_helper'

describe V1::EventsController, type: :request  do

  subject { JSON.parse( response.body) }
  let(:response_code) { response.status }

  describe '#index' do
    before { get v1_events_path, params: params }
    let(:params) { { retailer_id: retailer_id } }

    let(:retailer_id) { event.try(:store).try(:retailer_id) }
    let(:event) { create(:event) }

    it { should be_kind_of(Array) }

    describe 'response code' do
      subject { response_code }
      it { should be(200) }
    end

    # Happy path
    context 'when events are found' do
      it { should_not be_empty }
    end

    context 'when no events are found' do
      let(:event) { nil }
      let(:retailer_id) { 'this-wont-exist'}
      it { should be_empty }
    end

    # Sad path
    context 'when given bad params' do
      let(:params) { nil }
      subject { response_code }
      it { should be(400) }

      describe 'error message' do
        subject { JSON.parse(response.body)['message'] }
        it { should eq('Request must include retailer_id, retailer_id and date, or lat, long, and radius') }
      end
    end

    context 'when search by retailer_id' do
      describe 'response payload' do
        let(:first_item) { JSON.parse(response.body).first }

        describe 'id' do
          subject { first_item['id'] }
          it { should be_kind_of(Integer) }
          it { should eq(event.id) }
        end

        describe 'retailer' do
          subject { first_item['retailer'] }
          it { should be_kind_of(String) }
          it { should eq(event.store.retailer.name)}
        end

        describe 'lat' do
          subject { first_item['lat'] }
          it { should be_kind_of(Float) }
          it { should eq(event.lat) }
        end

        describe 'long' do
          subject { first_item['long'] }
          it { should be_kind_of(Float) }
          it { should eq(event.long) }
        end

        describe 'event_at' do
          subject { first_item['event_at'] }
          it { should be_kind_of(String) }

          context 'when converted to DateTime' do
            # For exact match
            subject { DateTime.parse(first_item['event_at']) }
            it { should eq(DateTime.parse(event.event_at.to_s))}
          end
        end
      end
    end

    context 'when searching by lat, long, and radius' do
      let(:lat)    { '1.41' }
      let(:long)   { '1.41' }
      let(:radius) { '20' }
      let(:event) { create(:event, lat: lat, long: long) }

      let(:params) { { lat: event.lat, long: event.long, radius: radius } }

      describe 'response payload' do
        let(:first_item) { JSON.parse(response.body).first }

        describe 'id' do
          subject { first_item['id'] }
          it { should be_kind_of(Integer) }
          it { should eq(event.id) }
        end

        describe 'retailer' do
          subject { first_item['retailer'] }
          it { should be_kind_of(String) }
          it { should eq(event.store.retailer.name)}
        end

        describe 'lat' do
          subject { first_item['lat'] }
          it { should be_kind_of(Float) }
          it { should eq(event.lat) }
        end

        describe 'long' do
          subject { first_item['long'] }
          it { should be_kind_of(Float) }
          it { should eq(event.long) }
        end

        describe 'event_at' do
          subject { first_item['event_at'] }
          it { should be_kind_of(String) }

          context 'when converted to DateTime' do
            # For exact match
            subject { DateTime.parse(first_item['event_at']) }
            it { should eq(DateTime.parse(event.event_at.to_s))}
          end
        end
      end

      # Happy path
      context 'when events are found' do
        it { should_not be_empty }
      end

      context 'when no events are found' do
        describe 'off by lat' do
          let(:params) { { lat: 100, long: event.long, radius: radius } }
          it { should be_empty }
        end

        describe 'off by long' do
          let(:params) { { lat: event.lat, long: 100, radius: radius } }
          it { should be_empty }
        end

        describe 'off by radius' do
          let(:radius) { 0 }
          it { should be_empty }
        end
      end

      # Sad path
      context 'when given bad params' do
        let(:params) { nil }
        subject { response_code }
        it { should be(400) }

        describe 'error message' do
          subject { JSON.parse(response.body)['message'] }
          it { should eq('Request must include retailer_id, retailer_id and date, or lat, long, and radius') }
        end
      end
    end

    context 'when searching by retailer_id and date' do
      let(:date) { '2014-05-01' }
      let(:event) { create(:event, event_at: "#{date} 21:11:08")}

      let(:params) { { retailer_id: retailer_id, date: date } }

      # Happy path
      context 'when events are found' do
        it { should_not be_empty }
      end

      context 'when no events are found' do
        let(:event) { nil }
        let(:retailer_id) { 'this-id-wont-exist' }
        it { should be_empty }
      end

      # Sad path
      context 'when given bad params' do
        let(:params) { nil }
        subject { response_code }
        it { should be(400) }

        describe 'error message' do
          subject { JSON.parse(response.body)['message'] }
          it { should eq('Request must include retailer_id, retailer_id and date, or lat, long, and radius') }
        end
      end

      describe 'response payload' do
        let(:first_item) { JSON.parse(response.body).first }

        describe 'id' do
          subject { first_item['id'] }
          it { should be_kind_of(Integer) }
          it { should eq(event.id) }
        end

        describe 'retailer' do
          subject { first_item['retailer'] }
          it { should be_kind_of(String) }
          it { should eq(event.store.retailer.name)}
        end

        describe 'lat' do
          subject { first_item['lat'] }
          it { should be_kind_of(Float) }
          it { should eq(event.lat) }
        end

        describe 'long' do
          subject { first_item['long'] }
          it { should be_kind_of(Float) }
          it { should eq(event.long) }
        end

        describe 'event_at' do
          subject { first_item['event_at'] }
          it { should be_kind_of(String) }

          context 'when converted to DateTime' do
            # For exact match
            subject { DateTime.parse(first_item['event_at']) }
            it { should eq(DateTime.parse(event.event_at.to_s))}
          end
        end
      end
    end

  end

end