require 'rails_helper'

RSpec.describe "number_parts/edit", type: :view do
  before(:each) do
    @number_part = assign(:number_part, NumberPart.create!(
      :type => "",
      :format => "MyString",
      :number_part_id => "",
      :current => 1
    ))
  end

  it "renders the edit number_part form" do
    render

    assert_select "form[action=?][method=?]", number_part_path(@number_part), "post" do

      assert_select "input#number_part_type[name=?]", "number_part[type]"

      assert_select "input#number_part_format[name=?]", "number_part[format]"

      assert_select "input#number_part_number_part_id[name=?]", "number_part[number_part_id]"

      assert_select "input#number_part_current[name=?]", "number_part[current]"
    end
  end
end
