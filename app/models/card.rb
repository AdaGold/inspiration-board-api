
VALID_EMOJIS = ["heart_eyes", "beer", "clap", "sparkling_heart", "heart_eyes_cat", "dog"]

class Card < ApplicationRecord
  belongs_to :board

  validate :valid_fields

  def self.valid_emojis
    return VALID_EMOJIS
  end





  def valid_fields
    if self.text.blank? && !VALID_EMOJIS.include?(self.emoji)
      errors.add(:text, "invalid text or missing emoji")
    end
  end
end
