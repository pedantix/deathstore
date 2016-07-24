require "rails_helper"

feature "viewing a directive" do
  let(:directive) { create :directive }
  let(:user) { directive.user }

  scenario "When Not Logged In Directive Should Be Visible but not creatable" do
    visit user_directives_path(user_id: user.id)

    expect(page).to have_text directive.content

    expect(page).not_to have_link t("application.top_bar.edit_directive")
    expect(page).not_to have_link t("application.top_bar.create_directive")
    expect(page).not_to have_link t("pages.home.download_directive"), href: qr_code_user_directives_path(user)
  end

  scenario "When viewing your own directive" do
    visit root_path
    click_on "Sign In"
    fill_form :user, email: user.email, password: user.password

    within "form" do
      click_on "Sign In"
    end

    expect(page).to have_text directive.content

    expect(page).to have_link t("application.top_bar.edit_directive")
    expect(page).to have_link t("pages.home.download_directive"), 
                              href: qr_code_user_directives_path(user)
  end
end

feature "creating a directive" do
  let(:user) { create :user }
  let(:content) { Faker::Lorem.paragraph }

  before do
    login_as user, scope: :user
    visit root_path
    click_on t("application.top_bar.create_directive")
  end

  scenario "with valid content" do
    fill_in "directive_content", with: content
    click_on t("directives.new.submit")

    expect(page).to have_text t("directives.create.success")
    expect(page).to have_text content
  end

  scenario "blank content" do
    fill_in "directive_content", with: ""
    click_on t("directives.new.submit")

    expect(page).to have_text t("directives.create.failure")
  end
end

feature "deleting a directive" do
  let(:user_without_directive) { create :user }
  let(:directive) { create :directive }
  let(:user_with_directive) { directive.user }

  scenario "should not be able to for user without directive" do
    login_as user_without_directive, scope: :user
    visit root_path
    expect(page).not_to have_link t("pages.home.delete_directive")

    expect(page).to have_link t("pages.home.create_directive")
  end

  scenario "deleting directive" do
    login_as user_with_directive, scope: :user

    visit root_path

    expect do
      click_on t("pages.home.delete_directive")
    end.to change(Directive, :count).by(-1)

    expect(page).to have_text t("directives.destroy.success")
  end
end

feature "editing a directive" do
  let(:user_without_directive) { create :user }
  let(:directive) { create :directive }
  let(:user_with_directive) { directive.user }
  let(:new_content) { Faker::Lorem.paragraph }

  scenario "should not be able to for user without directive" do
    login_as user_without_directive, scope: :user
    visit root_path
    expect(page).not_to have_link t("pages.home.edit_directive")

    expect(page).to have_link t("pages.home.create_directive")
  end

  scenario "valid content" do
    login_as user_with_directive, scope: :user

    visit root_path

    click_on t("pages.home.edit_directive")

    fill_in "directive_content", with: new_content
    click_on t("directives.edit.submit")

    expect(page).to have_text t("directives.update.success")
    expect(page).to have_text new_content
  end

  scenario "blank content" do
    login_as user_with_directive, scope: :user

    visit root_path

    click_on t("pages.home.edit_directive")
    fill_in "directive_content", with: ""
    click_on t("directives.edit.submit")

    expect(page).to have_text t("directives.update.failure")
  end
end
