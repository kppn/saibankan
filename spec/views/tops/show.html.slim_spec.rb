require 'rails_helper'

RSpec.describe "tops/show", type: :view do
  before(:each) do
    @top = assign(:top, Top.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
