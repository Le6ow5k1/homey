require 'rails_helper'

RSpec.describe "Project Status Changes", type: :system do
  let(:user) { User.create!(name: "Test User", email: "test@example.com") }
  let(:project) { Project.create!(name: "Test Project", status: "open") }

  before do
    driven_by(:selenium_chrome_headless)
    sign_in user
    visit project_path(project)
  end

  describe "changing project status" do
    context "with valid input" do
      it "updates the status and displays the change in the feed" do
        select "In progress", from: "Change status"
        fill_in "Reason for change", with: "Starting development"
        click_button "Update status"

        # Check activity feed shows the change
        within("#activity_feed") do
          expect(page).to have_content("Changed status from\nOpen\nto\nIn progress")
          expect(page).to have_content("Starting development")
          expect(page).to have_content(user.name)
        end
      end

      it "updates status without a reason" do
        select "In progress", from: "Change status"
        click_button "Update status"

        within("#activity_feed") do
          expect(page).to have_content("Changed status from\nOpen\nto\nIn progress")
        end
      end
    end

    context "with invalid input" do
      it "displays validation error when selecting the same status" do
        select "Open", from: "Change status"
        click_button "Update status"

        expect(page).to have_content("must be different from the previous status")
      end
    end

    context "when making multiple status changes" do
      it "shows status changes in reverse chronological order" do
        # First change
        select "In progress", from: "Change status"
        fill_in "Reason for change", with: "Starting work"
        click_button "Update status"
        sleep 1
        
        # Second change
        select "On hold", from: "Change status"
        fill_in "Reason for change", with: "Waiting for review"
        click_button "Update status"
        sleep 1

        expect(find("#activity_feed > div:nth-child(1)")).to have_content("Changed status from\nIn progress\nto\nOn hold")
        expect(find("#activity_feed > div:nth-child(1)")).to have_content("Waiting for review")
        expect(find("#activity_feed > div:nth-child(2)")).to have_content("Changed status from\nOpen\nto\nIn progress")
        expect(find("#activity_feed > div:nth-child(2)")).to have_content("Starting work")
      end
    end
  end
end 