class Calcs
  def operation(roll, operation_value, operator)
    case operator
    when 'add'
      return roll + operation_value
    when 'sub'
      return roll - operation_value
    when 'mult'
      return roll * operation_value
    when 'div'
      return roll.to_f / operation_value.to_f
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
