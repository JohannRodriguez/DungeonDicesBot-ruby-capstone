class Rolls
  @@crbl = Criticblunder.new
  @@calc = Calcs.new
  def single_roll(dice_value)
    roll = rand(1..dice_value)
    return "D#{dice_value} rolled, your roll is: \n #{roll}#{@@crbl.cr_bl_roll(dice_value, roll)}"
  end

  def multiple_rolls(dice_value, dices)
    rolls_array = ["D#{dice_value} #{dices} rolled, results:"]
    dices.times do
      roll = rand(1..dice_value)
      rolls_array.push("\n #{roll}#{@@crbl.cr_bl_roll(dice_value, roll)}")
    end
    rolls_array.join
  end

  def compare_roll(dice_value, comparison, comparer, multiple = nil)
    assign = assigners(comparer)
    comparer_text = assign[0]
    roll = rand(1..dice_value)
    if multiple.is_a?(Integer)
      rolls_comparison_array = ["D#{dice_value} #{comparer_text} than #{comparison}, results:"]
      multiple.times do
        roll = rand(1..dice_value)
        rolls_comparison_array.push("\n #{roll}#{@@crbl.cr_bl_roll(dice_value, roll)}, #{@@calc.compare(roll, comparison, comparer)}" )
      end
      return rolls_comparison_array.join
    end
    return "D#{dice_value} #{comparer_text} than #{comparison}, your roll is: \n #{roll}#{@@crbl.cr_bl_roll(dice_value, roll)}, #{@@calc.compare(roll, comparison, comparer)}"
  end

  def compare_roll_with_math(dice_value, comparison, comparer, operation_value, operator, multiple = nil)
    assign = assigners(comparer, operator)
    comparer_text = assign[0]
    operator_text = assign[1]
    operator_symbol = assign[2]
    roll = rand(1..dice_value)
    if multiple.is_a?(Integer)
      rolls_comparison_array = ["#{multiple} times D#{dice_value} #{operator_text} #{operation_value} #{comparer_text} than #{comparison}, your results are:"]
      multiple.times do
        roll = rand(1..dice_value)
        rolls_comparison_array.push(" \n #{roll}#{@@crbl.cr_bl_roll(dice_value, roll)}  #{operator_symbol} #{operation_value} = #{@@calc.operation(roll, operation_value, operator)}, #{@@calc.compare(@@calc.operation(roll, operation_value, operator), comparison, comparer)}")
      end
      return rolls_comparison_array.join
    end
    return "D#{dice_value} #{operator_text} #{operation_value} #{comparer_text} than #{comparison} your result is: \n #{roll}#{@@crbl.cr_bl_roll(dice_value, roll)}  #{operator_symbol} #{operation_value} = #{@@calc.operation(roll, operation_value, operator)}, #{@@calc.compare(@@calc.operation(roll, operation_value, operator), comparison, comparer)}"
  end

  def roll_with_operation(dice_value, operation_value, operator, multiple = nil)
    assign = assigners(nil, operator)
    operator_text = assign[1]
    operator_symbol = assign[2]
    roll = rand(1..dice_value)
    if multiple.is_a?(Integer)
      multiple_operator_array = [" #{multiple} times D#{dice_value} #{operator_text} #{operation_value}, your results are:"]
      multiple.times do
        roll = rand(1..dice_value)
        multiple_operator_array.push(" \n #{roll}#{@@crbl.cr_bl_roll(dice_value, roll)} #{operator_symbol} #{operation_value} = #{@@calc.operation(roll, operation_value, operator)}")
      end
      return multiple_operator_array.join
    end
    return "D#{dice_value} #{operator_text} #{operation_value}, your result is: \n #{roll}#{@@crbl.cr_bl_roll(dice_value, roll)} #{operator_symbol} #{operation_value} = #{@@calc.operation(roll, operation_value, operator)}"
  end

  def assigners(cm_txt = nil, op = nil)
    case cm_txt
    when 'smt'
      cm_txt_asg = 'smaller'
    when 'bgt'
      cm_txt_asg = 'bigger'
    end

    case op
    when 'add'
      op_txt_asg = 'plus' if op == 'add'
      op_sym_asg = '+' if op == 'add'
    when 'sub'
      op_txt_asg = 'minus' if op == 'sub'
      op_sym_asg = '-' if op == 'sub'
    when 'mult'
      op_txt_asg = 'times' if op == 'mult'
      op_sym_asg = '*' if op == 'mult'
    when 'div'
      op_txt_asg = 'divided by' if op == 'div'
      op_sym_asg = '/' if op == 'div'
    end
    return [cm_txt_asg, op_txt_asg, op_sym_asg]
  end
end