require 'rails_helper'

RSpec.describe "tops/index", type: :view do
  before(:each) do
    assign(:tops, [
      Top.create!(),
      Top.create!()
    ])
  end

  it "renders a list of tops" do
    render
  end
end
