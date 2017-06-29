class TagService
  def initialize(tags)
    @input_tags = tags.join || ""
    @tag_format_validator = Tag
      .validators
      .find { |validator| validator.instance_of? ActiveModel::Validations::FormatValidator }
      .options[:with]
    @tag_uniqueness_validator = Tag
      .validators
      .find { |validator| validator.instance_of? ActiveRecord::Validations::UniquenessValidator }
      .nil?
  end

  def tags
    tag_array = input_tags.split(/\s/).select { |tag| tag =~ tag_format_validator }
    tag_array = tag_array.uniq unless tag_uniqueness_validator
    tag_array.map { |tag| Tag.find_or_create_by(content: tag) }
  end

  private

  attr_reader :input_tags, :tag_format_validator, :tag_uniqueness_validator
end
