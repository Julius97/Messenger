class Status < ActiveRecord::Base

	belongs_to :status

	validates :content, :presence => true
	validates :user_id, :presence => true

end