require 'rails_helper'

RSpec.describe "number_parts/show", type: :view do
  before(:each) do
    @number_part = assign(:number_part, NumberPart.create!(
      :type => "Type",
      :format => "Format",
      :number_part_id => "",
      :current => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Format/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
