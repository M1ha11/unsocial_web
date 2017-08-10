class TagService
  def initialize(tags)
    @input_tags = tags || []
    @tag_format_validator = Tag
      .validators
      .find { |validator| validator.instance_of? ActiveModel::Validations::FormatValidator }
      .options[:with]
  end

  def tags
    tag_array = input_tags.select { |tag| tag =~ tag_format_validator }.uniq
    tag_array.map { |tag| Tag.find_or_create_by(content: tag) }
  end

  private

  attr_reader :input_tags, :tag_format_validator
end
