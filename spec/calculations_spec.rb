# spec/calculations_spec.#!/usr/bin/env ruby -wKU
require './lib/calculations.rb'

describe Calcs do
  let(:calc) { Calcs.new }
  describe '#operation' do
    it "If the third argument is 'add', the two first arguments will be added" do
      expect(calc.operation(8, 4, 'add')).to eql(12)
    end
    it "If the third argument is 'sub', the two first arguments will be substracted" do
      expect(calc.operation(8, 4, 'sub')).to eql(4)
    end
    it "If the third argument is 'mult', the two first arguments will be multiplied" do
      expect(calc.operation(8, 4, 'mult')).to eql(32)
    end
    it "If the third argument is 'div', the two firs arguments will be divided" do
      expect(calc.operation(8, 4, 'div')).to eql(2.0)
    end
  end

  describe '#compare' do
    it "If the third argument is 'smt' it will return a succes message if the frist argument is smaller than the second" do
        expect(calc.compare(5, 10, 'smt')).to eql('Succes!')
    end
    it "If the third argument is 'smt' it will return a failure message if the failure argument is bigger than the second" do
        expect(calc.compare(15, 10, 'smt')).to eql('Failure')
    end
    it "If the third argument is 'bgt' it will return a failure message if the first argument is smaller than the second" do
        expect(calc.compare(5, 10, 'bgt')).to eql('Failure')
    end
    it "If the third argument is 'bgt' it will return a succes message if the first argument is bigger than the second" do
        expect(calc.compare(15, 10, 'bgt')).to eql('Succes!')
    end
  end
end
