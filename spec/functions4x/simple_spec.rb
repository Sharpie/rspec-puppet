require 'spec_helper'

describe 'simple' do
  it { expect(subject).to run.with_params(1, 2).and_return(3) }
end
