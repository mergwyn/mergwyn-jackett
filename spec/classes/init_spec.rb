require 'spec_helper'
describe 'jackett' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with default values for all parameters' do
        it { is_expected.to contain_class('jackett') }
        it { is_expected.to contain_class('jackett::config') }
        it { is_expected.to contain_class('jackett::install') }
        it { is_expected.to contain_class('jackett::service') }
      end
    end
  end
end
