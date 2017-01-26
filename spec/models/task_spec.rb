require 'spec_helper'

describe Task do
  subject { task }
  let(:task) { create(:task) }

  it { should be_kind_of(Task) }

  describe '#offer relationship' do
    subject { Task.reflect_on_association(:offer).macro }
    it { should eq(:belongs_to) }
  end
end
