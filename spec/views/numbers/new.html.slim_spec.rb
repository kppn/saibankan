require 'rails_helper'

RSpec.describe "numbers/new", type: :view do
  before(:each) do
    assign(:number, Number.new(
      :allocated => "MyString",
      :project_id => ""
    ))
  end

  it "renders new number form" do
    render

    assert_select "form[action=?][method=?]", numbers_path, "post" do

      assert_select "input#number_allocated[name=?]", "number[allocated]"

      assert_select "input#number_project_id[name=?]", "number[project_id]"
    end
  end
end
