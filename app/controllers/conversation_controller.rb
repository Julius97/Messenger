class ConversationController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		redirect_to dashboard_index_path
	end

	def show
		if Conversation.find_by_id params[:id]
			@conversation = Conversation.find_by_id params[:id]
			@messages = Message.where(:conversation_id => @conversation.id).order(:created_at)
			if @conversation.contact.user_one_id == @current_user.id
	    		@partner_id = @conversation.contact.user_two_id
			else
				@partner_id = @conversation.contact.user_one_id
			end
			if Contact.where("user_one_id = ? AND user_two_id = ?", @current_user.id, @partner_id).count > 0
				@contact_id = Contact.where("user_one_id = ? AND user_two_id = ?", @current_user.id, @partner_id).first.id
			else
				@contact_id = Contact.where("user_one_id = ? AND user_two_id = ?", @partner_id, @current_user.id).first.id
			end
			@messages.where(:user_id => @partner_id, :read => false).each do |message|
				message.update_attributes :read => true
			end
		else
			redirect_to dashboard_index_path
		end
	end

	def new 
		
	end

	def create
		if !params[:partner_id].blank? && !params[:content].blank?
			if params[:partner_id].to_i != @current_user.id
				if Contact.where(:user_one_id => @current_user.id, :user_two_id => params[:partner_id].to_i).count > 0 || Contact.where(:user_two_id => @current_user.id, :user_one_id => params[:partner_id].to_i).count > 0
					if Contact.where(:user_one_id => @current_user.id, :user_two_id => params[:partner_id].to_i).first.conversation || Contact.where(:user_two_id => @current_user.id, :user_one_id => params[:partner_id].to_i).first.conversation
						if Contact.where(:user_one_id => @current_user.id, :user_two_id => params[:partner_id].to_i).first.conversation
							conversation = Contact.where(:user_one_id => @current_user.id, :user_two_id => params[:partner_id].to_i).first.conversation
						else
							conversation = Contact.where(:user_two_id => @current_user.id, :user_one_id => params[:partner_id].to_i).first.conversation
						end
						Message.create :content => params[:content], :conversation_id => conversation.id, :user_id => @current_user.id
						redirect_to conversation_path conversation.id
					else
						contact = Contact.create :user_one_id => @current_user.id, :user_two_id => params[:partner_id].to_i
						conversation = Conversation.create :contact_id => contact.id
						Message.create :content => params[:content], :conversation_id => conversation.id, :user_id => @current_user.id
						redirect_to conversation_path conversation.id
					end
				else
					contact = Contact.create :user_one_id => @current_user.id, :user_two_id => params[:partner_id].to_i
					conversation = Conversation.create :contact_id => contact.id
					Message.create :content => params[:content], :conversation_id => conversation.id, :user_id => @current_user.id
					redirect_to conversation_path conversation.id
				end
			else
				redirect_to dashboard_index_path
			end
		else
			redirect_to dashboard_index_path
		end
	end

end