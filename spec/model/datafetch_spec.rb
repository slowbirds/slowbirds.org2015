require 'spec_helper'

describe Datafetch do
  before { @datafetch = Datafetch.new }
  context 'when arg is unexisting' do
    it 'returns nil' do
      ret = @datafetch.getData('dummy')
      expect(ret).to eql(nil)
    end
  end

  context 'when arg is existing' do
    it 'returns json' do
      ret = @datafetch.getData('vimeo')
      expect(ret).not_to be_nil
    end
  end
end
