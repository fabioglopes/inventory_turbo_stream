class Item < ApplicationRecord
  # Option 1 will not include an item in the specific state page because the updates does not refresh the items list
  broadcasts_refreshes
  #

  # option 2 add a conditional to check if the status has changed and then refresh the items list
  #after_create_commit -> { broadcast_refresh_later_to "items" }
  #after_update_commit -> {
  #  if saved_change_to_status?
  #    broadcast_refresh_later_to "items"
  #  else
  #    broadcast_refresh_later
  #  end
  #}
  #after_destroy_commit -> { broadcast_refresh }

  # option 3 refresh the list for update, create and destroy. I will be slower
  #after_commit -> { broadcast_refresh_later_to("items") }

  # broadcast_refreshes will call all those callbacks update and destroy will be to the self
  #after_create_commit  -> { broadcast_refresh_later_to "items" }
  #after_update_commit  -> { broadcast_refresh_later }
  #after_destroy_commit -> { broadcast_refresh }
  #

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
