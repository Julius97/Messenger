class DashboardController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		@conversations = []
		Contact.where("user_one_id = ? OR user_two_id = ?",@current_user.id,@current_user.id).each do |contact|
			@conversations << contact.conversation if contact.conversation != nil
		end
	end

end