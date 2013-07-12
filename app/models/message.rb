class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text
  belongs_to :conversation, dependent: :destroy
  belongs_to :user
end
