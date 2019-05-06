class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :administrator, class_name: 'User'

  validate :start_must_be_after_now
  validate :is_multiple_of_5

  validates :start_date,
  presence: true

  validates :duration,
  presence: true,
  numericality: { greater_than: 4 }

  validates :title,
  presence: true,
  length: { in: 5..140 }

  validates :description,
  presence: true,
  length: { in: 20..1000 }

  validates :price,
  presence: true,
  numericality: { greater_than: 0, less_than: 1001 }

  validates :location,
  presence: true

  private

  def start_must_be_after_now
    errors.add(:start_date, "must be after now") unless
        start_date > Time.now
  end

  def is_multiple_of_5
    errors.add(:duration, "must be multiple of 5 and greater or equal to 5") unless
        duration % 5 == 0
  end 
end
