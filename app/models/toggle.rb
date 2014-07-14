class Toggle
  attr_accessor :name, :value, :environment, :description

  def initialize name, value, environment, description = ""
    @name = name
    @value = value
    @environment = environment
    @description = description
  end

end