class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  sluggable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # generate random 6 digit number
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twilio
    account_sid = 'ACb09da6a35805a8685b47ca61a44bd337' 
    auth_token = '25f6a2f32e5c068e53fe6e551c83c340'

    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 
 
    msg = "Hi, please input the pin to continue login: #{self.pin}"
    
    client.account.messages.create({
      :from => '+16502850767', 
      :to => '9252160296', 
      :body => msg,  
    })
  end

  def admin?
    self.permission == "admin" ? true : false
  end
end
