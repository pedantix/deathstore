require "rails_helper"

feature "Creating an account" do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  scenario "valid account creation" do
    visit root_path
    click_on t("pages.home.sign_up")

    fill_in "user_password", with: password
    fill_in "user_password_confirmation",  with: password
    fill_form :user, email: email
                     
    click_on t("devise.registrations.new.submit")

    expect(page).to have_link t("application.top_bar.sign_out")
    expect(page).not_to have_link t("pages.home.sign_up")
    expect(page).to have_content t("devise.registrations.signed_up")
  end 
end

feature "Signing into an account" do
  let(:user) { create :user }

  scenario "signing in" do
    visit root_path
    click_on t("application.top_bar.sign_in")

    fill_form :user, email: user.email,
                     password: user.password
    within "form" do
      click_on t("devise.sessions.new.sign_in")
    end

    expect(page).to have_link t("application.top_bar.sign_out")
    expect(page).not_to have_link t("pages.home.sign_up")
    expect(page).to have_text t("devise.sessions.signed_in")
  end
end

feature "Signing out" do
  let(:user) { create :user }

  before do
    login_as(user, scope: :user)
  end

  scenario "logging out" do
    visit root_path

    click_on t("application.top_bar.sign_out")

    expect(page).to have_text t("devise.sessions.signed_out")
  end
end

feature "password recover" do
  let(:user) { create :user }

  scenario "from login" do
    visit new_user_session_path
    click_on "Forgot"

    fill_form :user,  email: user.email
    click_on "Send"

    expect(page).to have_text t("devise.passwords.send_instructions")
  end
end
