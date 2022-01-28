require 'spec_helper'

describe ::User do
  describe '#managing?' do
    let(:owner) { build_stubbed(:user) }
    let(:manager) { build_stubbed(:user, :manager) }
    let(:worker) { build_stubbed(:user, :worker) }

    describe 'owner' do
      subject { owner.managing? }
      it { is_expected.to eq(true) }
    end

    describe 'manager' do
      subject { manager.managing? }
      it { is_expected.to eq(true) }
    end

    describe 'worker' do
      subject { worker.managing? }
      it { is_expected.to eq(false) }
    end
  end
end
