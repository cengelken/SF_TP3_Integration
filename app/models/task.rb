class Task < ActiveRecord::Base
  belongs_to :case
  validates :owner, :next_action, :due_date,:case_id, :presence => true
end
