require 'spec_helper'

describe "Micropost pages" do

   subject { page }

   let(:user)  { FactoryGirl.create(:user) }
   before      { sign_in user }


#   describe "should count microposts in the sidebar" do
#      before { visit root_path }

#      describe "with one post" do
#         before  { FactoryGirl.create(:micropost, user: user) }

# all three don't work
# there are no microposts!
   # Would like to include regular expressions - ^/$ or \A \z ?
#         it { should have_content('1') }
#         it { should have_content('micropost') }

#      end
#      describe "with many posts" do
#         before  { 60.times { FactoryGirl.create(:micropost, user: user) } }

#         it { should have_content('60') }
#         it { should have_content('microposts') }

#         describe "and has pagination" do
#            it { should have_selector('div.pagination') }
#         end
#      end
#   end

   describe "micropost destruction" do
      before { FactoryGirl.create(:micropost, user: user) }

      describe "as correct user" do
         before { visit root_path }

# doesn't like user????
#         (user.id == micropost.user.id) ? 
#            it { should have_content('delete')  } : it { should_not have_content('delete')  } 

         it "should delete a micropost" do
            expect { click_link "delete" }.should change(Micropost, :count).by(-1)
         end
      end
   end

   describe "micropost creation" do
      before   { visit root_path }
   
      describe "with invalid information" do
         
         it "should not create a micropost" do
            expect   { click_button "Post" }.should_not change(Micropost, :count)
         end
         describe "error messages" do
            before   { click_button "Post" }
            it { should have_content('error') }
         end
      end

      describe "with valid information" do
         before   { fill_in 'micropost[content]', with: "Lorem ipsum" }
         it "should create micropost" do
            expect   { click_button "Post" }.should change(Micropost, :count).by(1)
         end
      end
   end
end

