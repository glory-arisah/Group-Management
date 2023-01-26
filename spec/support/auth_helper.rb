module AuthHelper
  def sign_up_with(username, full_name, email, password)
    visit '/users/sign_up'

    fill_in "Username",	with: username
    fill_in "Full name", with: full_name
    fill_in "Email", with: email
    fill_in "Password",	with: password

    click_on "Sign up"
  end

  def log_in_attempt(email, password)
    visit "/users/sign_in"
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on "Log in"
  end
end
