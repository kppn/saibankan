require 'rails_helper'

RSpec.describe "marks/edit", type: :view do
  before(:each) do
    @mark = assign(:mark, Mark.create!(
      :owner => "",
      :label => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit mark form" do
    render

    assert_select "form[action=?][method=?]", mark_path(@mark), "post" do

      assert_select "input#mark_owner[name=?]", "mark[owner]"

      assert_select "input#mark_label[name=?]", "mark[label]"

      assert_select "input#mark_description[name=?]", "mark[description]"
    end
  end
end
