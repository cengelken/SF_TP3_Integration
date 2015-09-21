class CaseSet < ActiveRecord::Base
  has_many :cases, dependent: :destroy
  accepts_nested_attributes_for :cases, allow_destroy: true
end
