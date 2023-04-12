class Article < ApplicationRecord

  validates :title, presence: true, length: { minimum: 1, maximum: 50 }

  scope :active, -> {
    where(deleted_at: nil)
  }
end
