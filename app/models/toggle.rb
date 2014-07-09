class Toggle
  attr_accessor :name, :display_name, :value, :environment, :description

  def initialize name, display_name, value, environment, description = ""
    @name = name
    @display_name = display_name
    @value = value
    @environment = environment
    @description = description
  end

end