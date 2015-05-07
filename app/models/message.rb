class Message < ActiveRecord::Base

	belongs_to :user
	belongs_to :conversation

	validates :content, :presence => true
	validates :user_id, :presence => true
	validates :conversation_id, :presence => true

	after_validation :set_defaults
	after_save :set_conservaion_update_timestamp

	private
		def set_defaults
			self.read ||= false
		end

		def set_conservaion_update_timestamp
			Conversation.all.last.update_attributes :updated_at => DateTime.now
		end

end
