class Channel < ApplicationRecord
  has_many :items
  broadcasts_refreshes
end
