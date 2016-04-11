class Activity < ActiveRecord::Base
  belongs_to :experience
  belongs_to :roadmap

  validates :experience, presence: true
  validates :roadmap, presence: true

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
end
