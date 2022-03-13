# Override the default EnumValidator to remove the format_description
class EnumValidator < Apipie::Validator::BaseValidator
  def initialize(param_description, argument)
    super(param_description)
    @array = argument
  end

  def validate(value)
    @array.include?(value)
  end

  def self.build(param_description, argument, options, proc)
    self.new(param_description, argument) if argument.is_a?(Array)
  end

  def values
    @array
  end

  def description
    string = @array.join(', ')
    "Must be one of: #{string}."
  end
end

# Validator used to check that a supplied date is valid.
class DateValidator < Apipie::Validator::BaseValidator
  def initialize(param_description, type, options)
    super(param_description)
  end

  def validate(value)
    begin
      Date.parse(value)
      return true
    rescue => e
      return false
    end
  end

  def self.build(param_description, argument, options, proc)
    self.new(param_description, argument, options) if argument.to_s == 'DateValidator'
  end

  def description
    'Must be a valid date.'
  end
end


# Validator used to check a query parameter containing a list of values
# separated by a comma, that matches an array of values.
# eg. the agriculture_types query parameter.
class ListValidator < Apipie::Validator::BaseValidator
  def initialize(param_description, type, options)
    super(param_description)
    @array = options[:values]
  end

  def validate(value)
    list = value.split(',').map { |v| v.strip }
    return (list - @array).empty?
  end

  def self.build(param_description, argument, options, proc)
    self.new(param_description, argument, options) if !options[:values].nil?
  end

  def description
    string = @array.join(', ')
    "Must be one of: #{string}."
  end
end
