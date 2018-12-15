require 'spec_helper'
describe 'jackett' do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('jackett') }
  end
end
