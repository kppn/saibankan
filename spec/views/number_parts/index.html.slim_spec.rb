require 'rails_helper'

RSpec.describe "number_parts/index", type: :view do
  before(:each) do
    assign(:number_parts, [
      NumberPart.create!(
        :type => "Type",
        :format => "Format",
        :number_part_id => "",
        :current => 2
      ),
      NumberPart.create!(
        :type => "Type",
        :format => "Format",
        :number_part_id => "",
        :current => 2
      )
    ])
  end

  it "renders a list of number_parts" do
    render
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Format".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
