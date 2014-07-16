class Environment
  include ActiveModel::Validations
  attr_accessor :name

  validates_presence_of :name
  validates_format_of :name, with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores"
  validates_length_of :name, maximum: 30

  def initialize name
    @name = name
  end
end