class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :tasks, through: :task_labels
  enum color: {gray: 0, red: 1, blue: 2, green: 3, purple: 4}

  validates :name, uniqueness: true, presence: true, length: { maximum: 9 }
  
end
