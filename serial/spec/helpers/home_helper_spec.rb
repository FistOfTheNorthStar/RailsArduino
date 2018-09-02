require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe "create_payload" do
    it "is valid if sql_result is nil" do
      helper.create_payload(nil, 2).should eql({"data-t" => [0.0, 0.0], "data-h" => [0.0, 0.0]})
    end
  end
end
