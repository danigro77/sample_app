require 'spec_helper'

describe "Static pages" do

   subject { page }

   shared_examples_for "all static pages" do
		
      it { should have_selector('h1', text: heading)}
		it { should have_selector('title', text: full_title(page_title)) }

   end

   describe "Home page" do
      before { visit root_path }	
      let(:heading)     { 'Sample App' }
      let(:page_title)  { '' }

      it_should_behave_like "all static pages"
		it { should_not have_selector 'title', text: '| Home' }

      describe "for signed-in users" do
         let(:user) { FactoryGirl.create(:user) }
         before do
            FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
            FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
            sign_in user
            visit root_path
         end
         it "should render the user's feed" do
            user.feed.each do |item|
               page.should have_selector("li##{item.id}", text: item.content)
            end
         end
         describe "followers/following counts" do
            let(:other_user) { FactoryGirl.create(:user) }
            before do
               other_user.follow!(user)
               visit root_path
            end
            it { should have_link("0 following", href: following_user_path(user)) }
            it { should have_link("1 followers", href: followers_user_path(user)) }

            describe "stats" do
               it { should have_selector "div.stats" }
            end
         end
      end
   end

   describe "Help page" do
      before { visit help_path }	
      let(:heading)     { 'Help' }
      let(:page_title)  { 'Help' }

      it_should_behave_like "all static pages"

   end

   describe "About page" do
      before { visit about_path }	
      let(:heading)     { 'About Us' }
      let(:page_title)  { 'About Us' }

      it_should_behave_like "all static pages"

   end

   describe "Contact page" do
      before { visit contact_path }	
      let(:heading)     { 'Contact' }
      let(:page_title)  { 'Contact' }

      it_should_behave_like "all static pages"

   end

   it "should have the right links on the layout" do

      visit root_path
      click_link "About"
      page.should have_selector 'title', text: full_title('About Us')
      click_link "Help"
      page.should have_selector 'title', text: full_title('Help')
      click_link "Contact"
      page.should have_selector 'title', text: full_title('Contact')
      click_link "Home"
      click_link "Sign up now!"
      page.should have_selector 'title', text: full_title('Sign up')
      click_link "sample_app"
      page.should have_selector 'title', text: full_title('')

   end

#  describe "GET /static_pages" do
#    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)
#    end
#  end

end
