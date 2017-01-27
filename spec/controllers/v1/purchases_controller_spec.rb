require 'spec_helper'

describe V1::PurchasesController, type: :request  do

  subject { json }
  let(:json) { JSON.parse( response.body) }
  let(:response_code) { response.status }

  describe '#create' do
    before do
      customer.reload
      store.reload
    end

    before { post v1_purchases_path, params: params }
    let(:params) { { customer_id: customer_id, store_id: store_id, total_items: total_items, total_amount: total_amount } }

    let(:customer_id)  { customer.customer_id}
    let(:store_id)     { store.id }
    let(:customer)     { create(:customer) }
    let(:store)        { create(:store) }
    let(:total_items)  { 8294 }
    let(:total_amount) { 49.99}

    it { should be_kind_of(Hash) }

    describe 'response code' do
      subject { response_code }
      it { should be(201) }
    end

    describe 'response receipt' do
      describe 'id' do
        subject { json['id'] }
        it { should be_kind_of(Integer) }
      end

      describe 'name' do
        subject { json['name'] }
        it { should eq(store.retailer.name) }
      end

      describe 'address' do
        subject { json['address'] }
        it { should eq(store.address) }
      end

      describe 'city' do
        subject { json['city'] }
        it { should eq(store.city) }
      end

      describe 'state' do
        subject { json['state'] }
        it { should eq(store.state) }
      end

      describe 'zip' do
        subject { json['zip'] }
        it { should eq(store.zip) }
      end

      describe 'total_items' do
        subject { json['total_items'] }
        it { should eq(total_items) }
      end

      describe 'total_amount' do
        subject { json['total_amount'] }
        it { should eq(total_amount) }
      end

      describe 'datetime' do
        subject { json['datetime'] }
        it { should be_kind_of(String) }

        context 'when converted to DateTime' do
          # for better matching
          subject { DateTime.parse(json['datetime']).strftime('%Y-%m-%d') }
          let(:today) { DateTime.now.strftime('%Y-%m-%d') }
          it { should eq(today) }
        end
      end
    end

    # Sad path
    context 'when given bad params' do

      describe 'bad customer_id' do
        let(:customer_id) { 133 }  # This customer does not exist

        describe 'response code' do
          subject { response.status }
          it { should be(400) }
        end

        describe 'response payload' do
          it { should be_kind_of(Hash) }

          describe 'error type' do
            subject { json['error'] }
            it { should eq('bad request') }
          end

          describe 'error message' do
            subject { json['message'] }
            it { should eq('Validation failed: Customer must exist') }
          end
        end
      end

      describe 'bad store_id' do
        let(:store_id) { 133 }  # This store does not exist

        describe 'response code' do
          subject { response.status }
          it { should be(400) }
        end

        describe 'response payload' do
          it { should be_kind_of(Hash) }

          describe 'error type' do
            subject { json['error'] }
            it { should eq('bad request') }
          end

          describe 'error message' do
            subject { json['message'] }
            it { should eq('Validation failed: Store must exist') }
          end
        end
      end
    end

  end
end
