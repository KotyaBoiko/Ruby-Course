require 'date'

class Student 
  attr_accessor :surname, :name, :date_of_birth 
  @@students = [];
  def initialize (surname, name, date_of_birth)
    @surname = surname;
    @name = name;
    @date_of_birth = date_of_birth;
  end

  def calculate_age 
    p (Date.today - Date.parse(@date_of_birth)).to_i / 365
  end

  def add_student 
    student = {
      surname: @surname,
      name: @name,
      date_of_birth: @date_of_birth,
    }
    verification(student) ? p("Student already added") : @@students.push(student)
  end

  def remove_student 
    student = {
      surname: @surname,
      name: @name,
      date_of_birth: @date_of_birth,
    }
    index = verification(student);
    index ? @@students.delete_at(index) : "Student not found"
  end

  def get_students_by_age(age) 
    @@students.each do |person|
      if (Date.today - Date.parse(person[:date_of_birth])).to_i / 365 == age
        p person
      end
    end
  end

  def get_students_by_name(name) 
    @@students.each do |person|
      if person[:name] == name
        p person
      end
    end
  end

  private

  def verification(student) 
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

Kostia = Student.new("Boiko", "Kostia", "2005-08-26")
Sofia = Student.new("Izmalkova", "Sofia", "2005-08-26")
Kostia.add_student
Sofia.add_student

Sofia.get_students_by_age(19)
Kostia.get_students_by_name("Kostia")
Kostia.remove_student

p Student.class_variable_get("@@students")