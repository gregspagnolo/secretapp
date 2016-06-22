require 'rails_helper'

RSpec.describe LikesController, type: :controller do
	before do
		@user = create_user
	end
	describe "when not logged in" do
		visit '/secrets'
		expect(current_path).to eq('/sessions/new')
	end
	before do
		@user = create_user
		@user2 = create_user
		log_in @user
		@secret1 = @user2.secrets.create(content: "Secret")
		Like.create(user: @user2, secret: @secret1)
	end
	describe "when signed in as the wrong user" do
		visit '/secrets'
		expect(page).to have_text(@secret1.content)
		expect(page).not_to have_button('Unlike')

	end
end