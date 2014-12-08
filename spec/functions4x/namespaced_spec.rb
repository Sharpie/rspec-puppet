require 'spec_helper'

describe 'functions4x_test::namespaced' do
  it { expect(subject).to run.with_params(1, 2).and_return(3) }
end
