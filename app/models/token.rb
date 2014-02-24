class Token < ActiveRecord::Base
  attr_accessible :description, :name
  attr_reader :token
  belongs_to :user
  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:user_id]
  before_create :generate_token

  def short_token
    "#{@attributes["token"].first(5)}..."
  end

  private

  def generate_token
    begin
      token = Devise.friendly_token
    end while Token.where(:token => token.to_s).exists?
    self.token = token
  end
end
