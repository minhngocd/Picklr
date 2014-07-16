class Environment
  include ActiveModel::Validations
  attr_accessor :name

  validates_presence_of :name
  validates_format_of :name, with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores"
  validates_length_of :name, maximum: 30
  validate :name_not_exists

  def initialize name
    @name = name
  end

  private

  def name_not_exists
    errors.add(:environment, "Environment already exists") if EnvironmentsRepository.environment_exists? @name
  end
end