require 'rails_helper'

RSpec.describe "affiliations/show", type: :view do
  before(:each) do
    @affiliation = assign(:affiliation, Affiliation.create!(
      :project_id => "",
      :user_id => "",
      :administrator => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
