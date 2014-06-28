require 'spec_helper'
describe 'windows_role_oradb' do

  context 'with defaults for all parameters' do
    it { should contain_class('windows_role_oradb') }
  end
end
