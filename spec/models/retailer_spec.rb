require 'spec_helper'

describe Retailer do
  subject { retailer }
  let(:retailer) { create(:retailer) }

  it { should be_kind_of(Retailer) }

  describe '#stores relationship' do
    subject { Retailer.reflect_on_association(:stores).macro }
    it { should eq(:has_many) }
  end
end
