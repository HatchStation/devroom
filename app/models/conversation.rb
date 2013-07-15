class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :archived, type: Boolean, default: false

  default_scope where(:archived.ne => true)

  has_many :messages
  belongs_to :task
  has_and_belongs_to_many :users
end
