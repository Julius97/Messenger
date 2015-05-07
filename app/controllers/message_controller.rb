class MessageController < ApplicationController

	before_action -> { check_session(true,false) }
	
	def create
		if !params[:conversation_id].blank? && !params[:content].blank? && !params[:user_id].blank?
			Message.create :conversation_id => params[:conversation_id].to_i, :user_id => params[:user_id].to_i, :content => params[:content]
		end
		redirect_to conversation_path params[:conversation_id].to_i
	end

end