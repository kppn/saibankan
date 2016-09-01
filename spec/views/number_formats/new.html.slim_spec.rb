require 'rails_helper'

RSpec.describe "number_formats/new", type: :view do
  before(:each) do
    assign(:number_format, NumberFormat.new(
      :project_id => ""
    ))
  end

  it "renders new number_format form" do
    render

    assert_select "form[action=?][method=?]", number_formats_path, "post" do

      assert_select "input#number_format_project_id[name=?]", "number_format[project_id]"
    end
  end
end
