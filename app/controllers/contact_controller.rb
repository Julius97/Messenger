class ContactController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		@contacts = Contact.where("user_one_id = ? OR user_two_id = ?",@current_user.id,@current_user.id)
	end

	def show
		if params[:id]
			if Contact.find_by_id params[:id]
				@contact = Contact.find_by_id params[:id]
				if @contact.user_one_id == @current_user.id || @contact.user_two_id == @current_user.id
					if @contact.user_one_id != @current_user.id
						@user = @contact.user_one
					else
						@user = @contact.user_two
					end
				else
					redirect_to contact_index_path
				end
			else
				redirect_to contact_index_path
			end
		else
			redirect_to contact_index_path
		end
	end

	def search
		if params[:search_method]
			if !params[:search_method].blank? && !params[:search_input].blank?
				if params[:search_method] == "mail_address"
					@search_output = User.find_by_mail_address params[:search_input] if User.find_by_mail_address params[:search_input]
				else
					@search_output = User.find_by_nick_name params[:search_input] if User.find_by_nick_name params[:search_input]
				end
			end
		end
	end

	def create 
		if !params[:contact_id].blank?
			if User.find_by_id params[:contact_id].to_i
				if Contact.where(:user_one_id => @current_user, :user_two_id => params[:contact_id].to_i).count == 0 && Contact.where(:user_two_id => @current_user, :user_one_id => params[:contact_id].to_i).count == 0
					Contact.create :user_one_id => @current_user.id, :user_two_id => params[:contact_id].to_i
				end
			end
		end
		redirect_to contact_index_path
	end

end