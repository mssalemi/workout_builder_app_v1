# typed: true
class Types::ArrayStringType < GraphQL::Schema::Scalar
  description "An array of strings"
  
  def self.coerce_input(value, _context)
    if value.is_a?(Array) && value.all? { |item| item.is_a?(String) }
      value
    else
      raise GraphQL::CoercionError, "Input must be an array of strings"
    end
  end
  
  def self.coerce_result(value, _context)
    value
  end
end
