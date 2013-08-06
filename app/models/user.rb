class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  field :name
  field :admin, type: Boolean, default: false
  field :online, type: Boolean, default: false

  validates :name, presence: true

  has_many :messages
  has_many :tasks
  has_and_belongs_to_many :conversations

  def self.user_list
    only(:id, :name, :online).as_json
  end

  def self.check_for_inactive_users
    User.each do |u|
      u.update_attribute(:online, false) if (u.updated_at < 2.minutes.ago)
    end
    PrivatePub.publish_to "/users/list", :users => User.user_list
  end

end
