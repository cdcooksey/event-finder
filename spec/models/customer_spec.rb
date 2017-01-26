require 'spec_helper'

describe Customer do

  subject { customer }
  let(:customer) { create(:customer) }

  it { should be_kind_of(Customer) }

  describe '#events relationship' do
    subject { Customer.reflect_on_association(:events).macro }
    it { should eq(:has_many) }
  end

end