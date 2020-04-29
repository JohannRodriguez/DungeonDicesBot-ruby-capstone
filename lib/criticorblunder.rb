# lib/criticorblunder.rb
class Criticblunder
  @@critic = [[nil, nil, 4], [nil, nil, 6], [nil, nil, 8], [nil, nil, 8], [20, 20, 20], [1, 5, 100]]
  @@blunder = [[nil, nil, 4], [nil, nil, 6], [nil, nil, 8], [nil, nil, 8], [1, 1, 20], [95, 100, 100]]
  @@dice_index_array = [[4, 0], [6, 1], [8, 2], [10, 3], [20, 4], [100, 5]]
  @@valid_dice = [4, 6, 8, 10, 20, 100]

  attr_accessor :assigner_1
  attr_accessor :assigner_2
  attr_accessor :assigner_text_1
  attr_accessor :assigner_text_2
  # rubocop:disable Style/RedundantSelf
  def assign_new_critic_or_blunder(dice_type, values, type_of_assign)
    return "Invalid assigner, try to use either 'cr' or 'bl'" unless type_of_assign == 'cr' or type_of_assign == 'bl'

    dice_type_index = dice_index(dice_type)
    create_value_for_assigners(type_of_assign)
    return critic_or_blunder_none_value_set(values, dice_type, dice_type_index) if values == 'none'

    new_values = values.split('to')
    return 'You can only assign a maximum of two values' if new_values.length > 2

    return range_validation(new_values, dice_type_index) unless self.assigner_2[dice_type_index][0].nil?

    critic_or_blunder_new_values(new_values, dice_type_index)
    return "Your #{self.assigner_text_1} roll must be within a range from 1 to #{self.assigner_1[dice_type_index][2]}" if self.assigner_1[dice_type_index][0].nil? or self.assigner_1[dice_type_index][0].nil?

    return "The new value for D#{dice_type} #{self.assigner_text_1} is now #{self.assigner_1[dice_type_index][0]}" if self.assigner_1[dice_type_index][0] == self.assigner_1[dice_type_index][1]

    "The new #{self.assigner_text_1} range for D#{dice_type} goes from #{self.assigner_1[dice_type_index][0]} to #{self.assigner_1[dice_type_index][1]}"
  end

  def range_validation(new_values, dice_type_index)
    new_values.length.times do |i|
      if new_values[i].to_i.between?(self.assigner_2[dice_type_index][0], self.assigner_2[dice_type_index][1])
        return "#{self.assigner_text_2.capitalize} value is #{self.assigner_2[dice_type_index][0]}. You can't assign #{new_values[i].to_i} to #{self.assigner_text_1}" if self.assigner_1[dice_type_index][0] == self.assigner_1[dice_type_index][1]

        return "#{self.assigner_text_2.capitalize} range goes from #{self.assigner_2[dice_type_index][0]} to #{self.assigner_2[dice_type_index][1]}. You can't assign #{new_values[i].to_i} to #{self.assigner_text_1}"
      end
    end
  end

  # rubocop:disable Metrics/AbcSize
  def critic_or_blunder_new_values(new_values, dice_type_index)
    self.assigner_1[dice_type_index][0] = new_values[0].to_i if new_values[0].to_i.between?(1, self.assigner_1[dice_type_index][2])
    self.assigner_1[dice_type_index][1] = new_values[1].to_i if new_values.length > 1 and new_values[1].to_i.between?(1, self.assigner_1[dice_type_index][2])
    self.assigner_1[dice_type_index][1] = self.assigner_1[dice_type_index][0] if new_values.length == 1
    self.assigner_1[dice_type_index][1] = nil if self.assigner_1[dice_type_index][0].nil?
    self.assigner_1[dice_type_index][0] = nil if self.assigner_1[dice_type_index][1].nil?
    if self.assigner_1[dice_type_index][0].is_a?(Integer) and self.assigner_1[dice_type_index][1].is_a?(Integer)
      self.assigner_1[dice_type_index][0], self.assigner_1[dice_type_index][1] = self.assigner_1[dice_type_index][1], self.assigner_1[dice_type_index][0] if self.assigner_1[dice_type_index][0] > self.assigner_1[dice_type_index][1]
    end
  end

  def critic_blunder_status(dice_type, type_of_assign)
    dice_type_index = dice_index(dice_type)
    assigner = @@critic if type_of_assign == 'cr'
    assigner = @@blunder if type_of_assign == 'bl'
    type_of_assign_text = 'critic' if type_of_assign == 'cr'
    type_of_assign_text = 'blunder' if type_of_assign == 'bl'
    return "There is no range or value assigned for D#{dice_type} #{type_of_assign_text} roll" if assigner[dice_type_index][0].nil?

    return "The value assigned for D#{dice_type} #{type_of_assign_text} is #{assigner[dice_type_index][0]}" if assigner[dice_type_index][0] == assigner[dice_type_index][1]

    "The #{type_of_assign_text} range for D#{dice_type} goes from #{assigner[dice_type_index][0]} to #{assigner[dice_type_index][1]}"
  end

  def critic_blunder_roll(dice_type, roll)
    dice_type_index = dice_index(dice_type)
    return ' CRITIC ROLL!' if !@@critic[dice_type_index][0].nil? and roll.between?(@@critic[dice_type_index][0], @@critic[dice_type_index][1])

    return ' BLUNDER' if !@@blunder[dice_type_index][0].nil? and roll.between?(@@blunder[dice_type_index][0], @@blunder[dice_type_index][1])
  end

  def new_dice_critic_blunder(dice)
    @@critic.push([nil, nil, dice])
    @@blunder.push([nil, nil, dice])
    dice_index(nil, dice)
  end

  def dice_index(dice_type, new_dice = nil)
    if new_dice.is_a?(Integer)
      @@dice_index_array.push([new_dice, @@dice_index_array.length])
      accepted_dices(nil, new_dice)
      return "Dice succesfully added, you can use it as the rest of the dices using /d#{new_dice} with any variation to add diferent cualities to the roll"
    end
    @@dice_index_array.length.times { |i| return @@dice_index_array[i][1] if @@dice_index_array[i][0] == dice_type } unless dice_type.nil?
  end

  def accepted_dices(dice, new_dice = nil)
    if new_dice.is_a?(Integer)
      @@valid_dice.push(new_dice)
      return
    end
    return true if @@valid_dice.include?(dice) and !dice.nil?
    return false unless !dice.nil?
  end

  private

  # rubocop:enable Metrics/AbcSize
  def critic_or_blunder_none_value_set(value, dice_value, dtp)
    self.assigner_1[dtp][0] = nil
    self.assigner_1[dtp][1] = nil
    "#{self.assigner_text_1.capitalize} D#{dice_value} value setted to none"
  end

  def create_value_for_assigners(type_of_assign_validation)
    if type_of_assign_validation == 'cr'
      self.assigner_1 = @@critic
      self.assigner_2 = @@blunder
      self.assigner_text_1 = 'critic'
      self.assigner_text_2 = 'blunder'
    end
    if type_of_assign_validation == 'bl'
      self.assigner_1 = @@blunder
      self.assigner_2 = @@critic
      self.assigner_text_1 = 'blunder'
      self.assigner_text_2 = 'critic'
    end
  end
  # rubocop:enable Style/RedundantSelf
end
