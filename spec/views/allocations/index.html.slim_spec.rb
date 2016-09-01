require 'rails_helper'

RSpec.describe "allocations/index", type: :view do
  before(:each) do
    assign(:allocations, [
      Allocation.create!(
        :project_id => "",
        :user_id => "",
        :number_id => ""
      ),
      Allocation.create!(
        :project_id => "",
        :user_id => "",
        :number_id => ""
      )
    ])
  end

  it "renders a list of allocations" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
