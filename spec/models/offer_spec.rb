require 'spec_helper'

describe Offer do
  subject { offer }
  let(:offer) { create(:offer) }

  it { should be_kind_of(Offer) }

  describe '#tasks relationship' do
    subject { Offer.reflect_on_association(:tasks).macro }
    it { should eq(:has_many) }
  end
end
