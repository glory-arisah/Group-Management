require "rails_helper"

RSpec.describe "Users", type: :system do
  before { driven_by(:rack_test) }

  let!(:user1) { create(:user, email: "earisah@gmail.com") }

  scenario "can view welcome page if unauthenticated" do
    visit "/"
    expect(page).to have_content("Welcome to GM")
    expect(page).to have_link("Sign up")
    expect(page).to have_link("Log in")
  end

  describe "Sign up:" do
    context "with valid credentials" do
      scenario "can sign up successfully" do
        sign_up_with "jarisah", "Jay Arisah", "jarisah@gmail.com", "jarisah"

        expect(page).to have_content("Owned groups")
        expect(page).to have_link("Create Group")
        expect(page).to have_current_path("/")
      end
    end

    context "with invalid credentials:" do
      scenario "cannot sign up when email already exists" do
        sign_up_with "earisah", "E Arisah", "earisah@gmail.com", "earisah"

        expect(page).to have_text("has already been taken")
      end

      scenario "cannot sign up if password is less than 6 characters" do
        sign_up_with "earisah", "E Arisah", "earisah@gmail.com", "jjj"

        expect(page).to have_text("is too short")
      end
    end
  end

  describe "Sign in:" do
    context "with valid credentials" do
      scenario "user can sign in successfully" do
        log_in_attempt user1.email, user1.password
        expect(page).to have_text("Hello #{user1.username}!")
      end

      scenario "user can sign out successfully" do
        log_in_attempt user1.email, user1.password
        click_on "Sign out"

        expect(page).to have_text("Welcome to GM")
      end
    end

    context "with invalid credentials" do
      scenario "with empty fields" do
        log_in_attempt "", ""

        expect(page).to have_text("Invalid Email or password")
      end

      scenario "with non-existing credentials" do
        log_in_attempt "garisah@gmail.com", "earisah"

        expect(page).to have_text("Invalid Email or password")
      end
    end
  end
end
