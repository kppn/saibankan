require 'rails_helper'

RSpec.describe "affiliations/edit", type: :view do
  before(:each) do
    @affiliation = assign(:affiliation, Affiliation.create!(
      :project_id => "",
      :user_id => "",
      :administrator => false
    ))
  end

  it "renders the edit affiliation form" do
    render

    assert_select "form[action=?][method=?]", affiliation_path(@affiliation), "post" do

      assert_select "input#affiliation_project_id[name=?]", "affiliation[project_id]"

      assert_select "input#affiliation_user_id[name=?]", "affiliation[user_id]"

      assert_select "input#affiliation_administrator[name=?]", "affiliation[administrator]"
    end
  end
end
