require 'rails_helper'

RSpec.describe "tops/edit", type: :view do
  before(:each) do
    @top = assign(:top, Top.create!())
  end

  it "renders the edit top form" do
    render

    assert_select "form[action=?][method=?]", top_path(@top), "post" do
    end
  end
end
