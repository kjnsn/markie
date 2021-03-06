require 'rails_helper'

RSpec.describe "Bookmarks", :type => :request do
  #include Devise::TestHelpers

  describe "GET /bookmarks" do
    it "gets redirected if not logged in" do
      get bookmarks_path
      expect(response.status).to eq(302)
    end

    it "gets index when logged in" do
      sign_in_as_a_valid_user
      get bookmarks_path
      expect(response.status).to eq(200)
    end
  end

  describe "Adds bookmarks" do
    it "adds a bookmark" do
      sign_in_as_a_valid_user
      get_via_redirect "/http://google.com"
      expect(Bookmark.all.last.url).to eq("http://google.com")
    end
  end

  describe "DELETE /bookmark/:id" do
    it "does not delete someone elses bookmark" do
      bookmark = create(:bookmark)
      sign_in_as_a_valid_user
      get_via_redirect "/http://google.com"
      delete_via_redirect url_for(bookmark)
      expect(Bookmark.find(bookmark.id)).to eq(bookmark)
    end
  end
end
