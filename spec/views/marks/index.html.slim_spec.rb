require 'rails_helper'

RSpec.describe "marks/index", type: :view do
  before(:each) do
    assign(:marks, [
      Mark.create!(
        :owner => "",
        :label => "Label",
        :description => "Description"
      ),
      Mark.create!(
        :owner => "",
        :label => "Label",
        :description => "Description"
      )
    ])
  end

  it "renders a list of marks" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
