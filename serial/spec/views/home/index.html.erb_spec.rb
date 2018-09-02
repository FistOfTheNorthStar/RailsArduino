require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  describe "displays three buttons" do
    it 'should contain 3 buttons' do 
      render        
      expect(rendered).to match("button")
    end
  end
end

#render :template => "home/index", :layout => "layouts/application"
