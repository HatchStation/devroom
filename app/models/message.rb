class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text
  belongs_to :conversation
  belongs_to :user
end
