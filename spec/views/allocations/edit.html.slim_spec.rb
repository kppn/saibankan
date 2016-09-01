require 'rails_helper'

RSpec.describe "allocations/edit", type: :view do
  before(:each) do
    @allocation = assign(:allocation, Allocation.create!(
      :project_id => "",
      :user_id => "",
      :number_id => ""
    ))
  end

  it "renders the edit allocation form" do
    render

    assert_select "form[action=?][method=?]", allocation_path(@allocation), "post" do

      assert_select "input#allocation_project_id[name=?]", "allocation[project_id]"

      assert_select "input#allocation_user_id[name=?]", "allocation[user_id]"

      assert_select "input#allocation_number_id[name=?]", "allocation[number_id]"
    end
  end
end
