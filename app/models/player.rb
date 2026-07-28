class Player < ActiveRecord::Base
  BASE_XP_REQUIREMENT = 100

  has_many :quests, dependent: :destroy

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

  def add_experience!(amount)
    new_xp = current_xp + amount
    new_level = calculate_level(new_xp)

    update!(
      current_xp: new_xp,
      level: new_level
    )
  end

  private

  def calculate_level(experience)
    calculated_level = 1
    remaining_xp = experience

    while remaining_xp >= xp_required_for_next_level(calculated_level)
      remaining_xp -= xp_required_for_next_level(calculated_level)
      calculated_level += 1
    end

    calculated_level
  end

  def xp_required_for_next_level(current_level)
    current_level * BASE_XP_REQUIREMENT
  end
end
