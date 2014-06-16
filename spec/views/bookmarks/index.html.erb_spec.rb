require 'rails_helper'

RSpec.describe "bookmarks/index", :type => :view do
  before(:each) do
    assign(:bookmarks, [
      Bookmark.create!(
        :url => "Url",
        :title => "Title",
        :user_id => 1
      ),
      Bookmark.create!(
        :url => "Url",
        :title => "Title",
        :user_id => 1
      )
    ])
  end

  it "renders a list of bookmarks" do
    render
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
