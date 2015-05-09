class StatusController < ApplicationController

	before_action -> { check_session(true,false) }

	def show
		if params[:id]
			if Status.find_by_id params[:id]
				@status = Status.find_by_id params[:id]
			else
				redirect_to dashboard_index_path
			end
		else
			redirect_to dashboard_index_path
		end
	end

	def edit
		if params[:id]
			if Status.find_by_id params[:id]
				@status = Status.find_by_id params[:id]
			else
				redirect_to dashboard_index_path
			end
		else
			redirect_to dashboard_index_path
		end
	end

	def update
		if !params[:content].blank?
			@current_user.status.update_attributes :content => params[:content]
		end
		redirect_to status_path @current_user.status.id
	end

end