require 'rails_helper'

RSpec.describe "affiliations/index", type: :view do
  before(:each) do
    assign(:affiliations, [
      Affiliation.create!(
        :project_id => "",
        :user_id => "",
        :administrator => false
      ),
      Affiliation.create!(
        :project_id => "",
        :user_id => "",
        :administrator => false
      )
    ])
  end

  it "renders a list of affiliations" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
