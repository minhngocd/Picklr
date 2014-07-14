
class ApplicationFeature
  include ActiveModel::Validations

  attr_accessor :name, :display_name, :description

  validates_presence_of :name, :display_name
  validates_format_of :name, with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores"
  validates_length_of :name, maximum: 30

  def initialize name, display_name, description
    @name = name
    @display_name = display_name
    @description = description
  end
end