class Contact < ActiveRecord::Base

	belongs_to :user_one, class_name: "User", foreign_key: "user_one_id"
	belongs_to :user_two, class_name: "User", foreign_key: "user_two_id"
	has_one :conversation

	validates :user_one_id, :presence => true
	validates :user_two_id, :presence => true

end