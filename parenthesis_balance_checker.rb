# Attach custom methods to String Ruby class
class String

  REGEX_ONLY_PARENTHESES = /[^\(\)]+/
  REGEX_VALID_CHARS = /[^\(\)\:]+/
  REGEX_SMILEYS = /(\:\))|(\(\:)/

  def balance_status
    return "balanceado" if self.strip == "" # In case of empty string
    return "balanceado" if self.strip == "(:)" # Usual case
    return "desbalanceado" if self.strip.start_with?(")") # If start with close parenthesis
    return "balanceado" if self.no_alpha == ""
    return "desbalanceado" if self.start_with_closing_parentheses
    return "desbalanceado" if self.end_with_starting_parentheses

    no_alpha.no_smileys.balanced
  end

  def no_alpha
    self.gsub(REGEX_VALID_CHARS, "")
  end

  def no_smileys
    self.gsub(REGEX_SMILEYS, "")
  end

  def start_with_closing_parentheses
    self.gsub(REGEX_VALID_CHARS, "").start_with?(")")
  end

  def end_with_starting_parentheses
    self.gsub(REGEX_VALID_CHARS, "").end_with?("(")
  end

  def parentheses_size
    self.scan(/\(/).flatten.compact.size - self.scan(/\)/).flatten.compact.size
  end

  def balanced
    self.parentheses_size == 0 ? 'balanceado' : 'desbalanceado'
  end

end


puts "Introduce your text to check: "
string = gets

puts "Your result is:"
puts string.chomp.balance_status