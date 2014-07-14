class Toggle
  attr_accessor :feature, :environment, :value

  def initialize feature, environment, value
    @feature = feature
    @environment = environment
    @value = value
  end

end