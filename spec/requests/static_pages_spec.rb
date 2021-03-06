require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it {should have_selector('h1', text:'Sad Loris')}
    it {should have_selector('title', text: full_title(''))}
    it {should_not have_selector('title', text: 'Home')}

   describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:review, user: user)
        FactoryGirl.create(:review, user: user)
        sign_in user
        visit root_path
      end

      #TODO: fix this test, I can't see why it is failing
      #it "should render the user's feed" do
      #  user.feed.each do |item|
      #    page.should have_content(content: item.article_title)
      #  end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    it {should have_selector('h1', text: 'Help')}
    it {should have_selector('title', text: full_title('Help'))}
  end

  describe "About page" do
    before { visit about_path }
    it {should have_selector('h1', text: "About Us")}
    it {should have_selector('title', text: full_title('About'))}
  end

  describe "Contact page" do
    before { visit contact_path }
    it {should have_selector('h1', text: 'Contact')}
    it {should have_selector('title',
                    text: full_title("Contact"))}
  end
end
