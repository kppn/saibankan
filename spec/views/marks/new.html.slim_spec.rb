require 'rails_helper'

RSpec.describe "marks/new", type: :view do
  before(:each) do
    assign(:mark, Mark.new(
      :owner => "",
      :label => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new mark form" do
    render

    assert_select "form[action=?][method=?]", marks_path, "post" do

      assert_select "input#mark_owner[name=?]", "mark[owner]"

      assert_select "input#mark_label[name=?]", "mark[label]"

      assert_select "input#mark_description[name=?]", "mark[description]"
    end
  end
end
