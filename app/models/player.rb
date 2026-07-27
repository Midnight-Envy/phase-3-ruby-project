class Player < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  validates :level,
            numericality: {
              only_integer: true,
              greater_than: 0,
            }

  validates :current_xp,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
            }
end
