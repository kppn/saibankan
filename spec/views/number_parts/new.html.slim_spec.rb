require 'rails_helper'

RSpec.describe "number_parts/new", type: :view do
  before(:each) do
    assign(:number_part, NumberPart.new(
      :type => "",
      :format => "MyString",
      :number_part_id => "",
      :current => 1
    ))
  end

  it "renders new number_part form" do
    render

    assert_select "form[action=?][method=?]", number_parts_path, "post" do

      assert_select "input#number_part_type[name=?]", "number_part[type]"

      assert_select "input#number_part_format[name=?]", "number_part[format]"

      assert_select "input#number_part_number_part_id[name=?]", "number_part[number_part_id]"

      assert_select "input#number_part_current[name=?]", "number_part[current]"
    end
  end
end
