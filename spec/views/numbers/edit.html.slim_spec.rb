require 'rails_helper'

RSpec.describe "numbers/edit", type: :view do
  before(:each) do
    @number = assign(:number, Number.create!(
      :allocated => "MyString",
      :project_id => ""
    ))
  end

  it "renders the edit number form" do
    render

    assert_select "form[action=?][method=?]", number_path(@number), "post" do

      assert_select "input#number_allocated[name=?]", "number[allocated]"

      assert_select "input#number_project_id[name=?]", "number[project_id]"
    end
  end
end
