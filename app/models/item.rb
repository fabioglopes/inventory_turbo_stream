class Item < ApplicationRecord
  broadcasts_refreshes
  after_commit -> { broadcast_replace_to("items")}
  # this one needed if we destroy through console
  after_destroy -> { broadcast_remove_to("items")}

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
