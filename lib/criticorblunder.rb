class Criticblunder
  @@critic = [[nil, nil, 4],[nil, nil, 6], [nil, nil, 8], [nil, nil, 8], [20, 20, 20], [1, 5, 100]]
  @@blunder = [[nil, nil, 4],[nil, nil, 6], [nil, nil, 8], [nil, nil, 8], [1, 1, 20], [95, 100, 100]]
  @@dice_index_array =[[4, 0],[6, 1],[8, 2],[10, 3],[20, 4],[100, 5]]
  @@valid_dice = [4, 6, 8, 10, 20, 100]
  def cr_bl_assign(dice_type, values, type_of_assign)
    return "Invalid assigner, try to use either 'cr' or 'bl'" unless type_of_assign == 'cr' or type_of_assign == 'bl'
    dice_type_index = dice_index(dice_type)
    assigners = assigners_validation(type_of_assign)
    assigner_1 = assigners[0]
    assigner_2 = assigners[1]
    assigner_text_1 = assigners[2]
    assigner_text_2 = assigners[3]
    return value_none(values, assigner_1, assigner_text_1, dice_type, dice_type_index) if values == 'none'
    new_values = values.split('to')
    return 'You can only assign a maximum of two values' if new_values.length > 2
    return range_validation(assigner_2, assigner_1, assigner_text_2, assigner_text_1, new_values, dice_type_index) unless assigner_2[dice_type_index][0].nil?
    set_values_for_assigner(assigner_1, new_values, dice_type_index)
    return "Your #{assigner_text_1} roll must be within a range from 1 to #{assigner_1[dice_type_index][2]}" if assigner_1[dice_type_index][0].nil? or
    return "The new value for D#{dice_type} #{assigner_text_1} is now #{assigner_1[dice_type_index][0]}" if assigner_1[dice_type_index][0] == assigner_1[dice_type_index][1]
    return "The new #{assigner_text_1} range for D#{dice_type} goes from #{assigner_1[dice_type_index][0]} to #{assigner_1[dice_type_index][1]}"
  end

  def range_validation(assigner_2, assigner_1, assigner_text_2,assigner_text_1, new_values, dice_type_index)
    new_values.length.times do |i|
      if new_values[i].to_i.between?(assigner_2[dice_type_index][0], assigner_2[dice_type_index][1])
        return "#{assigner_text_2.capitalize} value is #{assigner_2[dice_type_index][0]}. You can't assign #{new_values[i].to_i} to #{assigner_text_1}" if assigner_1[dice_type_index][0] == assigner_1[dice_type_index][1]
        return "#{assigner_text_2.capitalize} range goes from #{assigner_2[dice_type_index][0]} to #{assigner_2[dice_type_index][1]}. You can't assign #{new_values[i].to_i} to #{assigner_text_1}"
      end
    end
  end

  def set_values_for_assigner(as_1, new_values, dice_type_index)
    as_1[dice_type_index][0] = new_values[0].to_i if new_values[0].to_i.between?(1, as_1[dice_type_index][2])
    as_1[dice_type_index][1] = new_values[1].to_i if new_values.length > 1 and new_values[1].to_i.between?(1, as_1[dice_type_index][2])
    as_1[dice_type_index][1] = as_1[dice_type_index][0] if new_values.length == 1
    as_1[dice_type_index][1] = nil if as_1[dice_type_index][0] == nil
    as_1[dice_type_index][0] = nil if as_1[dice_type_index][1] == nil
    if as_1[dice_type_index][0].is_a?(Integer) and as_1[dice_type_index][1].is_a?(Integer)
      as_1[dice_type_index][0], as_1[dice_type_index][1] = as_1[dice_type_index][1], as_1[dice_type_index][0] if as_1[dice_type_index][0] > as_1[dice_type_index][1]
    end
  end

  def value_none(value, as_1, as_1_text, dice_value, dtp)
      as_1[dtp][0] = nil
      as_1[dtp][1] = nil
      return "#{as_1_text.capitalize} D#{dice_value} value setted to none"
  end

  def assigners_validation(type_of_assign_validation)
    if type_of_assign_validation == 'cr'
      assigner_1_validation = @@critic
      assigner_2_validation = @@blunder
      assigner_text_1_validation = 'critic'
      assigner_text_2_validation = 'blunder'
    end
    if type_of_assign_validation == 'bl'
      assigner_1_validation = @@blunder
      assigner_2_validation = @@critic
      assigner_text_1_validation = 'blunder'
      assigner_text_2_validation = 'critic'
    end
    return [assigner_1_validation, assigner_2_validation, assigner_text_1_validation, assigner_text_2_validation]
  end

  def cr_bl_status(dice_type, type_of_assign)
    dice_type_index = dice_index(dice_type)
    assigner = @@critic if type_of_assign == 'cr'
    assigner = @@blunder if type_of_assign == 'bl'
    type_of_assign_text = 'critic' if type_of_assign == 'cr'
    type_of_assign_text = 'blunder' if type_of_assign == 'bl'
    return "There is no range or value assigned for D#{dice_type} #{type_of_assign_text} roll" if assigner[dice_type_index][0].nil?
    return "The value assigned for D#{dice_type} #{type_of_assign_text} is #{assigner[dice_type_index][0]}" if assigner[dice_type_index][0] == assigner[dice_type_index][1]
    return "The #{type_of_assign_text} range for D#{dice_type} goes from #{assigner[dice_type_index][0]} to #{assigner[dice_type_index][1]}"
  end
end
