require 'spec_helper'

describe ::Freeday do
  describe '#cancelled?' do
    let(:cancelled) { build_stubbed(:freeday, user_id: 1, rejected_by_id: 1, status: 'rejected') }
    let(:rejected) { build_stubbed(:freeday, user_id: 1, rejected_by_id: 2, status: 'rejected') }

    describe 'cancelled' do
      subject { cancelled.cancelled? }
      it { is_expected.to eq(true) }
    end

    describe 'rejected' do
      subject { rejected.cancelled? }
      it { is_expected.to eq(false) }
    end
  end
end
