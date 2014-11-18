require 'spec_helper'

describe Datafetch do
  it "should print String" do
    expect(Datafetch.new.puts).to be_instance_of String
  end
end
