require 'rails_helper'

RSpec.describe "numbers/index", type: :view do
  before(:each) do
    assign(:numbers, [
      Number.create!(
        :allocated => "Allocated",
        :project_id => ""
      ),
      Number.create!(
        :allocated => "Allocated",
        :project_id => ""
      )
    ])
  end

  it "renders a list of numbers" do
    render
    assert_select "tr>td", :text => "Allocated".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
