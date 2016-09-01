require 'rails_helper'

RSpec.describe "number_formats/edit", type: :view do
  before(:each) do
    @number_format = assign(:number_format, NumberFormat.create!(
      :project_id => ""
    ))
  end

  it "renders the edit number_format form" do
    render

    assert_select "form[action=?][method=?]", number_format_path(@number_format), "post" do

      assert_select "input#number_format_project_id[name=?]", "number_format[project_id]"
    end
  end
end
