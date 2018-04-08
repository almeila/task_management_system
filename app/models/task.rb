class Task < ApplicationRecord
  belongs_to :user

  include AASM
  enum priority: {low: 0, normal: 1, high: 2}

  validates :title, :content, :end_period, :priority, presence: true
  validates :title, length: { maximum: 30 }
  validates :content, length: { maximum: 500 }
  validate :end_period_check, on: :create

  aasm column: :status do
    state :waiting,initial: true
    state :working 
    state :completed

    event :work do
      transitions from: :waiting, to: :working
    end

    event :complete do
      transitions from: :working, to: :completed
    end

  end

  def transitionable_state_option_by
    [[I18n.t("view.tasks.#{status}"), '']].concat(self.aasm.events.map(&:name).map{|state| [I18n.t("view.tasks.#{state}"), state] })
  end

  private

    def end_period_check
      if self.end_period.present?
        errors.add(:end_period, I18n.t('model.tasks.end_period_error_message')) unless self.end_period > Time.now
      end
    end
end
