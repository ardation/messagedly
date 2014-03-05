class Device < ActiveRecord::Base
	belongs_to :user
	attr_accessible :channel_name
	before_create :generate_access_token
	attr_readonly :access_token
	as_enum :status,  %w{unassigned inactive active}

	protected

	def generate_access_token
		self.access_token = loop do
			random_token = SecureRandom.urlsafe_base64(nil, false)[0..5].upcase
			break random_token unless Device.where(access_token: random_token).exists?
		end
	end
end
