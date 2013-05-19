class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :confirmation_token, :confirmation_sent_at, :confirmed_at, :subscribed
  # attr_accessible :title, :body
  scope :confirmed, where('confirmed_at is not null')	

  mount_uploader :avatar, AvatarUploader

  def subscribe(user)
    subscribed_user = User.find(user)
    subscribed_user.subscribed = true
  end

end
