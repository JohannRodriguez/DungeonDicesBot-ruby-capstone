# spec/ccriticorblunder_spec.#!/usr/bin/env ruby -wKU
require './lib/criticorblunder.rb'

describe Criticblunder do
  let(:crbl) { Criticblunder.new }
  describe '#cr_bl_assign' do
    it 'If the third argument is not accepted returns a meesage to sugest using a valid one' do
      expect(crbl.cr_bl_assign(4, '3to4', 'vr')).to eql("Invalid assigner, try to use either 'cr' or 'bl'")
    end
    it 'If the arguments are valid and the second one has two numbers, returns a message saying the faces of the dice we passed, if is critic or blunder and the range' do
      expect(crbl.cr_bl_assign(4, '3to4', 'cr')).to eql("The new critic range for D4 goes from 3 to 4")
    end
    it 'If the arguments ar valid and the second one is one number, returns a msesage saying the faces of the dice we passed, if is critic or blunder and the value' do
      expect(crbl.cr_bl_assign(4, '4', 'cr')).to eql('The new value for D4 critic is now 4')
    end
    it 'If your seond argument is none, it will set the critic value to nil adn return a message saying there is no value' do
      expect(crbl.cr_bl_assign(4, 'none', 'cr')).to eql('Critic D4 value setted to none')
    end
    it "If you try to asign a nuumber that of blunder(bl) wich is the same as a value for critic, it will return a message that says the number you can't assign" do
      expect(crbl.cr_bl_assign(100, '3to6', 'bl')).to eql("Critic range goes from 1 to 5. You can't assign 3 to blunder")
    end
    it 'If you try to put more than two values in the thir argument, it will return a meesage saying you can only add two or less' do
      expect(crbl.cr_bl_assign(100, '3to6to7', 'bl')).to eql('You can only assign a maximum of two values')
    end
    it 'If a number of the second argument is bigger than the first one, it will return a message saying the range of numbers you can pick from' do
      expect(crbl.cr_bl_assign(8, '7to9', 'cr')).to eql('Your critic roll must be within a range from 1 to 8')
    end
  end

  describe '#cr_bl_status' do
    it "Checks an array, if there is no value assigned for 'cr' or 'bl', it will return a message sayin there isn't one" do
      expect(crbl.cr_bl_status(10, 'cr')).to eql('There is no range or value assigned for D10 critic roll')
    end
    it "If there is one a value assigned for 'cr' or 'bl', it will return a message saying the value and the dice" do
      expect(crbl.cr_bl_status(20, 'bl')).to eql('The value assigned for D20 blunder is 1')
    end
    it "If there are two values assigned for 'cr' or 'bl', it will return a message saying the range and the dice" do
      expect(crbl.cr_bl_status(100, 'cr')).to eql('The critic range for D100 goes from 1 to 5')
    end
  end

  describe '#cr_bl_roll' do
    it 'Checks two arrays determined by the first argument, if the second argument number is inside the array, it will return a message saying you got a blunder' do
      expect(crbl.cr_bl_roll(20, 1)).to eql(' BLUNDER')
    end
    it 'Checks two arrays determined by the first argument, if the second argument number is inside the array, it will return a message saying you got a critic' do
      expect(crbl.cr_bl_roll(100, 5)).to eql(' CRITIC ROLL!')
    end
  end

  describe '#dice_index' do
    it 'Adds a new dice determined by the second argument, it will return a message sayin it was added and the name of the dice' do
      expect(crbl.dice_index(4, 5)).to eql('Dice succesfully added, you can use it as the rest of the dices using /d5 with any variation to add diferent cualities to the roll')
    end
  end
end
