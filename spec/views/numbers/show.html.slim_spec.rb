require 'rails_helper'

RSpec.describe "numbers/show", type: :view do
  before(:each) do
    @number = assign(:number, Number.create!(
      :allocated => "Allocated",
      :project_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Allocated/)
    expect(rendered).to match(//)
  end
end
