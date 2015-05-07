class UserController < ApplicationController

	before_action -> { check_session(false,false) }

	def index
		
	end

	def new
		redirect_to dashboard_index_path if @current_user
	end

	def create
		if !@current_user
			if params[:nick_name] && params[:mail] && params[:repeated_mail] && params[:password] && params[:repeated_password]
				successful_registration = false
				if !params[:nick_name].blank? && !params[:mail].blank? && !params[:repeated_mail].blank? && !params[:password].blank? && !params[:repeated_password].blank?
				    if params[:mail] == params[:repeated_mail]
				    	if params[:password] == params[:repeated_password]
				    		if !User.find_by_mail_address params[:mail] && !User.find_by_nick_name params[:nick_name]
				    			if User.where(:nick_name => params[:nick_name]).count == 0
									User.create :password => params[:password], :nick_name => params[:nick_name], :admin_permissions => false, :mail_address => params[:mail]
									successful_registration = true
								end
							end
						end
					end
				end
				if successful_registration
					redirect_to login_path
				else
					redirect_to register_path
				end
			end
		else
			redirect_to dashboard_index_path
		end
	end

end