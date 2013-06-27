class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :messages
  has_and_belongs_to_many :users
end
