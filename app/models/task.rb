class Task < ApplicationRecord
  validates :title, :content, :end_period, presence: true
  validates :title, length: { maximum: 30 }
  validates :content, length: { maximum: 500 }
  validate :end_period_check

  private

    def end_period_check
      if self.end_period.present?
        errors.add(:end_period, I18n.t('model.tasks.end_period_error_message')) unless self.end_period > Time.now
      end
    end
end
