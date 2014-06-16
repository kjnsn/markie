require 'rails_helper'

RSpec.describe "bookmarks/new", :type => :view do
  before(:each) do
    assign(:bookmark, Bookmark.new(
      :url => "MyString",
      :title => "MyString",
    ))
  end

  it "renders new bookmark form" do
    render

    assert_select "form[action=?][method=?]", bookmarks_path, "post" do

      assert_select "input#bookmark_url[name=?]", "bookmark[url]"

      assert_select "input#bookmark_title[name=?]", "bookmark[title]"

    end
  end
end
