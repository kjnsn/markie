require 'rails_helper'

RSpec.describe Bookmark, :type => :model do
  it "should not save a blank bookmark" do
    expect(Bookmark.new.save).to be(false)
  end
end
