class Quest < ActiveRecord::Base
  DIFFICULTIES = %w[Easy Medium Hard].freeze

  belongs_to :player

  validates :title, presence: true
  validates :difficulty, presence: true, inclusion: { in: DIFFICULTIES }
  validates :xp_reward,
            numericality: {
              only_integer: true,
              greater_than: 0,
            }
end
