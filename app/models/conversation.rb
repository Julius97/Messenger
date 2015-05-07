class Conversation < ActiveRecord::Base

	has_many :messages
	belongs_to :contact, class_name: "Contact", foreign_key: "contact_id"

	validates :contact_id, :presence => true

end