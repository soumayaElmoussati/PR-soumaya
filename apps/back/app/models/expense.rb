class Expense < ApplicationRecord
  belongs_to :offer

  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  has_many :cloud_expense_pictures, dependent: :destroy
  accepts_nested_attributes_for :cloud_expense_pictures, allow_destroy: true

  validates_associated :pictures, :cloud_expense_pictures

  after_create :notify_slack

  enum state: [
    :draft,
    :pending_validation,
    :validate
  ], _prefix: :expenses

  private

  def notify_slack
    CreateExpenseJob.perform_later(self)
  end


end
