class Activity < ActiveRecord::Base
  belongs_to :experience
  belongs_to :roadmap

  validates :experience, presence: true
  validates :roadmap, presence: true

  after_validation :position_it

  default_scope { order(position: :asc) }

  def up
    return false if self == sisters.first
    old = sisters.find { |a| a.position == self.position - 1 }
    old.update(position: self.position)
    self.update(position: self.position - 1)
  end

  def down
    return false if self == sisters.last
    old = sisters.find { |a| a.position == self.position + 1 }
    old.update(position: self.position)
    self.update(position: self.position + 1)
  end

  def sisters
    self.roadmap.activities
  end

  def planned_on
    return self.roadmap.start_date if self.roadmap.single_day?
    return self[:planned_on]
  end

  # Method Forwarding to self.experience cause self.experience.category is Ugly AF
  def method_missing(method_sym, *args, &block)
    return self.experience.send(method_sym, *args, &block) if (self.experience.respond_to? method_sym)
    raise NoMethodError, "Undefined method #{method_sym} for #{self.class}"
  end

  # Redefining respond_to? to account for method_missing definition
  def respond_to?(sym, include_private = false)
    self.experience.respond_to? sym || super(sym, include_private)
  end

  private

  def position_it
    self.update(position: sisters.length) if position.nil?
  end
end
