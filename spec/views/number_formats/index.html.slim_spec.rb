require 'rails_helper'

RSpec.describe "number_formats/index", type: :view do
  before(:each) do
    assign(:number_formats, [
      NumberFormat.create!(
        :project_id => ""
      ),
      NumberFormat.create!(
        :project_id => ""
      )
    ])
  end

  it "renders a list of number_formats" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
