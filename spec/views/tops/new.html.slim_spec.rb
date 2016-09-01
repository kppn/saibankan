require 'rails_helper'

RSpec.describe "tops/new", type: :view do
  before(:each) do
    assign(:top, Top.new())
  end

  it "renders new top form" do
    render

    assert_select "form[action=?][method=?]", tops_path, "post" do
    end
  end
end
