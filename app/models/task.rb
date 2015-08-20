class Task < ActiveRecord::Base
  belongs_to :case
  validates :owner, :next_action, :due_date, :presence => true
end
