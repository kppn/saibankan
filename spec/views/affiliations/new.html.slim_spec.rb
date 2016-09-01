require 'rails_helper'

RSpec.describe "affiliations/new", type: :view do
  before(:each) do
    assign(:affiliation, Affiliation.new(
      :project_id => "",
      :user_id => "",
      :administrator => false
    ))
  end

  it "renders new affiliation form" do
    render

    assert_select "form[action=?][method=?]", affiliations_path, "post" do

      assert_select "input#affiliation_project_id[name=?]", "affiliation[project_id]"

      assert_select "input#affiliation_user_id[name=?]", "affiliation[user_id]"

      assert_select "input#affiliation_administrator[name=?]", "affiliation[administrator]"
    end
  end
end
