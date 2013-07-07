class Device < ActiveRecord::Base
	belongs_to :user
	attr_accessible :access_token, :channel_name

	before_create :generate_confirmation_code

	attr_readonly :confirmation_code

	protected

	def generate_confirmation_code
		self.confirmation_code = loop do
			random_token = SecureRandom.urlsafe_base64(nil, false)
			break random_token unless Device.where(confirmation_code: random_token).exists?
		end
	end
end
