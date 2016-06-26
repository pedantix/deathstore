require "rails_helper"

feature "Creating an account" do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  scenario "valid account creation" do
    visit root_path
    click_on t("pages.home.sign_up")

    fill_form :user, email: email,
                     password: password, 
                     password_confirmation: password
    click_on "Sign up"

    expect(page).to have_link t("pages.home.sign_out")
    expect(page).not_to have_link t("pages.home.sign_up")
    expect(page).to have_content t("devise.registrations.signed_up")
  end 
end

feature "Signing into an account" do
  let(:user) { create :user }

  scenario "signing in" do
    visit root_path
    click_on t("pages.home.sign_in")

    fill_form :user, email: user.email,
                     password: user.password
    click_on "Log in"

    expect(page).to have_link t("pages.home.sign_out")
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

    click_on t("pages.home.sign_out")

    expect(page).to have_text t("devise.sessions.signed_out")
  end
end
