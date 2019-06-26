require 'rspec/autorun'

class Person
  def initialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  def full_name
    return "#{ @first_name } #{ @last_name }" if @middle_name.nil?

    "#{ @first_name } #{ @middle_name } #{ @last_name }"
  end

  def full_name_with_middle_initial
    return full_name if @middle_name.nil?

    "#{ @first_name } #{ @middle_name[0] }. #{ @last_name }"
  end

  def initials
    [@first_name[0], (@middle_name || [])[0], @last_name[0]].compact
                                                            .join(' ')
  end
end

describe Person do
  describe '#full_name' do
    it 'concatenates first name, middle name, and last name with spaces' do
      person = Person.new(first_name: 'A', middle_name: 'B', last_name: 'C')

      expect(person.full_name).to eq 'A B C'
    end

    it 'does not add extra spaces if middle name is missing' do
      person = Person.new(first_name: 'A', last_name: 'C')

      expect(person.full_name).to eq 'A C'
    end
  end

  describe '#full_name_with_middle_initial' do
    it 'returns full name with middle initial' do
      person = Person.new(
        first_name: 'Rahul',
        middle_name: 'Man',
        last_name: 'Steve'
      )

      expect(person.full_name_with_middle_initial).to eq 'Rahul M. Steve'
    end

    it 'returns full name w/o middle initial if its nil' do
      person = Person.new(first_name: 'Rahul', last_name: 'Mohanraj')

      expect(person.full_name_with_middle_initial).to eq 'Rahul Mohanraj'
    end
  end

  describe '#initials' do
    it 'returns all the initials' do
      person = Person.new(
        first_name: 'Rahul',
        middle_name: 'Man',
        last_name: 'Steve'
      )

      expect(person.initials).to eq 'R M S'
    end

    it 'returns all the initials w/o space when middle name is nil' do
      person = Person.new(first_name: 'Rahul', last_name: 'Mohanraj')

      expect(person.initials).to eq 'R M'
    end
  end
end
