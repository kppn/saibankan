require 'rails_helper'

RSpec.describe "number_formats/show", type: :view do
  before(:each) do
    @number_format = assign(:number_format, NumberFormat.create!(
      :project_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
