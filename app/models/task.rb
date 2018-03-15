class Task < ApplicationRecord
  validates :title, :content, :end_period, presence: true
end
