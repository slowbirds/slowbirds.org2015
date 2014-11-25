require 'spec_helper'

describe Datafetch do
  it "existing API" do
    real_obj = Datafetch.new
    double_obj = double('datafetch')

    ret = Datafetch.new.getData("vim")
    ret
  end
end
