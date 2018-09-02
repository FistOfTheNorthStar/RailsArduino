require 'rails_helper'

RSpec.describe "home/index.html.", type: :view do
  describe "displays three buttons" do
    before(:each) do
      @t24 = {"data-t": [5.0, 5.0], "data-h": [5.0, 5.0]}
      @week = {"data-t": [6.0, 6.0], "data-h": [6.0, 6.0]}
      @month = {"data-t": [7.0, 7.0], "data-h": [7.0, 7.0]}
      render :template => "home/index.html.haml"
    end    

    it "should contain 3 buttons" do
      #not best practise, but added one after another, testing capybara 
      rendered.should match("24Hours")
      rendered.should match("pastWeek")
      rendered.should match("pastMonth")
      expect(rendered).to have_css(".buttonG", :count => 3)
    end
    
    it "should contain data field t24, week, month" do
      rendered.should have_selector("#t24[data-h=\"[5.0, 5.0]\"]")
      rendered.should have_selector("#week[data-h=\"[6.0, 6.0]\"]")
      rendered.should have_selector("#month[data-h=\"[7.0, 7.0]\"]")
    end
    
   


  end
end

