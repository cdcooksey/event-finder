require 'spec_helper'

describe Receipt do
  subject { receipt }
  let(:receipt) { create(:receipt) }

  it { should be_kind_of(Receipt) }

  describe '#store relationship' do
    subject { Receipt.reflect_on_association(:store).macro }
    it { should eq(:belongs_to) }
  end

  describe '#customer relationship' do
    subject { Receipt.reflect_on_association(:customer).macro }
    it { should eq(:belongs_to) }
  end
end