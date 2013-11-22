require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Navpreet Singh"
        fill_in "Email",        with: "navpreet.singh@gmail.com"
        fill_in "Password",     with: "waheguru"
        fill_in "Confirmation", with: "waheguru"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:users) { User.find_by(email: 'navpreet.singh@gmail.com') }
        debugger
        it { should have_title(full_title(users.name)) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end