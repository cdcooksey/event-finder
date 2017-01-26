require 'spec_helper'

describe Store do
  subject { store }
  let(:store) { create(:store) }

  it { should be_kind_of(Store) }

  describe '#retailer relationship' do
    subject { Store.reflect_on_association(:retailer).macro }
    it { should eq(:belongs_to) }
  end

  describe '#events relationship' do
    subject { Store.reflect_on_association(:events).macro }
    it { should eq(:has_many) }
  end
end
