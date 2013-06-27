class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :messages
  has_many :participants, class_name: 'User', inverse_of: 'conversation'
end
