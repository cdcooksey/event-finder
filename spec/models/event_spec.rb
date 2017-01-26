require 'spec_helper'

describe Event do

  describe '#store relationship' do
    subject { Event.reflect_on_association(:store).macro }
    it { should eq(:belongs_to) }
  end

  describe '#customer relationship' do
    subject { Event.reflect_on_association(:customer).macro }
    it { should eq(:belongs_to) }
  end

  describe '#find_by_retailer_id' do
    subject { action }

    let(:event) { create(:event) }
    let(:retailer_id) { event.store.retailer_id}
    let(:action) { Event.find_by_retailer_id(retailer_id) }

    it { should be_kind_of(ActiveRecord::Relation) }

    describe 'Event instance' do
      subject { action.first }
      it { should be_kind_of(Event) }
      it { should eq(event) }
    end

    # Sad path
    context 'when no results are found' do
      let(:retailer_id) { 829379237 }
      it { should be_empty }
      it { should be_kind_of(ActiveRecord::Relation) }
    end
  end
end
