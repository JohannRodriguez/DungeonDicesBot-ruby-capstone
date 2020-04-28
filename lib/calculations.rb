# lib/calculations.rb
class Calcs
  def operation(roll, operation_value, operator)
    case operator
    when 'add'
      roll + operation_value
    when 'sub'
      roll - operation_value
    when 'mult'
      roll * operation_value
    when 'div'
      roll.to_f / operation_value
    end
  end

  def compare(roll, comparison, comparer)
    if comparer == 'smt'
      return 'Succes!' if roll < comparison
      return 'Failure' if roll >= comparison
    end
    if comparer == 'bgt'
      return 'Succes!' if roll > comparison
      return 'Failure' if roll <= comparison
    end
  end
end
