require 'rails_helper'

RSpec.describe "marks/show", type: :view do
  before(:each) do
    @mark = assign(:mark, Mark.create!(
      :owner => "",
      :label => "Label",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Label/)
    expect(rendered).to match(/Description/)
  end
end
