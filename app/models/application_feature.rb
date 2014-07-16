
class ApplicationFeature
  include ActiveModel::Validations

  attr_accessor :name, :description

  validates_presence_of :name
  validates_format_of :name, with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores"
  validates_length_of :name, maximum: 30
  validate :name_not_exists

  def initialize name, description
    @name = name
    @description = description
  end

  private

  def name_not_exists
    errors.add(:application_feature, "Feature already exists") if FeaturesRepository.feature_exists? @name
  end
end