require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require 'date'
require_relative "../Homework 1/student"


Minitest::Reporters.use! [
  Minitest::Reporters::SpecReporter.new,
  Minitest::Reporters::HtmlReporter.new(
    reports_dir: 'Homework 2/reports/spec',
    report_filename: 'spec_results.html',
    clean: true,
    add_timestamp: true
  )
]

describe Student do
  before do
    @student1 = Student.new("Boiko", "Kostia", "2005-08-26")
    @student2 = Student.new("Izmalkova", "Sofia", "2004-09-13")

    @student1.add_student
    @student2.add_student
  end

  after do
    Student.class_variable_set(:@@students, [])
  end

  describe '#calculate_age' do
  it 'calculates the correct age for student1' do
    expect(@student1.calculate_age).must_equal(19)
  end

  it 'calculates the correct age for student2' do
    expect(@student2.calculate_age).must_equal(20)
  end
end

describe '#add_student' do
  it 'returns a message when the student is already added' do
    expect(@student1.add_student).must_equal("Student already added")
  end
end

describe '.verification' do
  it 'verifies that an existing student is recognized' do
    expect(!!Student.verification({
      surname: "Boiko",
      name: "Kostia",
      date_of_birth: "2005-08-26",
    })).must_equal(true)
  end

  it 'does not verify a non-existing student' do
    expect(Student.verification({
      surname: "Stupka",
      name: "Petro",
      date_of_birth: "2004-08-26",
    })).must_equal(false)
  end
end

describe '#remove_student' do
  it 'removes the student correctly' do
    @student1.remove_student
    expect(Student.verification({
      surname: "Boiko",
      name: "Kostia",
      date_of_birth: "2005-08-26",
    })).must_equal(false)
  end
end

describe '.get_students_by_age' do
  it 'returns the correct student by age' do
    expect(Student.get_students_by_age(19)).must_equal([{
      surname: "Boiko",
      name: "Kostia",
      date_of_birth: "2005-08-26",
    }])
  end
end

describe '.get_students_by_name' do
  it 'returns the correct student by name' do
    expect(Student.get_students_by_name("Sofia")).must_equal([{
      surname: "Izmalkova",
      name: "Sofia",
      date_of_birth: "2004-09-13",
    }])
  end
end
end