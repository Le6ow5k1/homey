require 'rails_helper'

RSpec.describe "Project Comments", type: :system do
  let(:user) { User.create!(name: "Test User", email: "test@example.com") }
  let(:project) { Project.create!(name: "Test Project", status: "open") }

  before do
    driven_by(:selenium_chrome_headless)
    sign_in user
    visit project_path(project)
  end

  describe "adding a comment" do
    context "with valid input" do
      it "creates a new comment and displays it in the feed" do
        fill_in "Add a comment", with: "This is a test comment"
        click_button "Post comment"

        within("#activity_feed") do
          expect(page).to have_content("This is a test comment")
          expect(page).to have_content(user.name)
        end
      end
    end

    context "with invalid input" do
      it "displays validation errors" do
        fill_in "Add a comment", with: ""
        click_button "Post comment"

        expect(page).to have_content("can't be blank")
      end
    end

    context "when adding multiple comments" do
      it "shows comments in reverse chronological order" do
        fill_in "Add a comment", with: "First comment"
        click_button "Post comment"
        
        fill_in "Add a comment", with: "Second comment"
        click_button "Post comment"

        expect(find("#activity_feed > div:nth-child(1)")).to have_content("Second comment")
        expect(find("#activity_feed > div:nth-child(2)")).to have_content("First comment")
      end
    end
  end
end 