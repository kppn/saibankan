require 'rails_helper'

RSpec.describe "allocations/new", type: :view do
  before(:each) do
    assign(:allocation, Allocation.new(
      :project_id => "",
      :user_id => "",
      :number_id => ""
    ))
  end

  it "renders new allocation form" do
    render

    assert_select "form[action=?][method=?]", allocations_path, "post" do

      assert_select "input#allocation_project_id[name=?]", "allocation[project_id]"

      assert_select "input#allocation_user_id[name=?]", "allocation[user_id]"

      assert_select "input#allocation_number_id[name=?]", "allocation[number_id]"
    end
  end
end
