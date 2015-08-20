class Case < ActiveRecord::Base
  belongs_to :case_set
  has_many :tasks
  validates :case_num, :presence => true
end
