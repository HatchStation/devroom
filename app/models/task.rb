class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String
  field :resolved, type: Boolean, default: false
  has_one :conversation
  belongs_to :user

  validates :description, presence: true, length: {minimum: 10}
end
