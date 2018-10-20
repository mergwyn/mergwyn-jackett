require 'spec_helper'
describe 'jackett' do
  context 'with default values for all parameters' do
    it { should contain_class('jackett') }
  end
end
