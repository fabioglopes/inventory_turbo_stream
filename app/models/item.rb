class Item < ApplicationRecord
  #broadcasts_refreshes
  after_commit -> { broadcast_refresh_to("items") }

  validates_presence_of :sku

  include AASM

  aasm column: :status do
    state :pending, initial: true
    state :approved

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :pending do
      transitions from: :approved, to: :pending
    end

    event :toggle do
      transitions from: :pending, to: :approved
      transitions from: :approved, to: :pending
    end
  end
end
