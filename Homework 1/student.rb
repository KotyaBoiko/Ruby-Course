require 'date'

class Student 
  attr_accessor :surname, :name, :date_of_birth 
  @@students = [];
  def initialize (surname, name, date_of_birth)
    raise ArgumentError, "Date of birth must be in past" if
    Date.parse(date_of_birth) > Date.today
    @surname = surname;
    @name = name;
    @date_of_birth = date_of_birth;
  end

  def calculate_age 
    (Date.today - Date.parse(@date_of_birth)).to_i / 365
  end

  def add_student 
    student = {
      surname: @surname,
      name: @name,
      date_of_birth: @date_of_birth,
    }
    Student.verification(student) ? "Student already added" : @@students.push(student)
  end

  def remove_student 
    student = {
      surname: @surname,
      name: @name,
      date_of_birth: @date_of_birth,
    }
    index = Student.verification(student);
    index ? @@students.delete_at(index) : "Student not found"
  end

  def self.get_students_by_age(age) 
    studens_by_age = []
    @@students.each do |person|
      if (Date.today - Date.parse(person[:date_of_birth])).to_i / 365 == age
        studens_by_age.push(person)
      end
    end
    return studens_by_age
  end

  def self.get_students_by_name(name) 
    students_by_name = []
    @@students.each do |person|
      if person[:name] == name
        students_by_name.push(person)
      end
    end
    return students_by_name
  end

  private

  def self.verification(student) 
    @@students.each_with_index do |person, index|
      equal = 0
      person.each do |key, value|
        if value == student[key]
          equal += 1
        end
      end
      if equal == 3
        return index
      end
    end
    return false
  end

end