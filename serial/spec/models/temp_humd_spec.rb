require 'rails_helper'

RSpec.describe TempHumd, :type => :model do
  # pretty useless as to_f converts anything except number strings to 0.0 even nils
  it "is valid with both T & H inputs" do
    expect(TempHumd.new).to be_valid
  end
end
