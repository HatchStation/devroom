class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  has_one :conversation, inverse_of: nil
end
