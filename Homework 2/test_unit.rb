require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require_relative "../Homework 1/student"

Minitest::Reporters.use! [
  Minitest::Reporters::HtmlReporter.new(
    reports_dir: 'Homework 2/reports/unit',
    report_filename: 'test_results.html',
    clean: true,
    add_timestamp: true
  )
]

class UserTest < Minitest::Test
  def setup
    @student1 = Student.new("Boiko", "Kostia", "2005-08-26")
    @student2 = Student.new("Izmalkova", "Sofia", "2004-09-13")

    @student1.add_student
    @student2.add_student
  end

  def teardown
    Student.class_variable_set(:@@students, [])
  end

  def test_calculate_age
    assert_equal 19, @student1.calculate_age
    assert_equal 20, @student2.calculate_age
  end

  def test_add_student
    assert_equal "Student already added", @student1.add_student
  end

  def test_verification 
    assert Student.verification({
      surname: "Boiko",
      name: "Kostia",
      date_of_birth: "2005-08-26",
    })

    assert !Student.verification({
      surname: "Stupka",
      name: "Petro",
      date_of_birth: "2004-08-26",
    })
  end

  def test_remove_student
    @student1.remove_student
    assert !Student.verification({
      surname: "Boiko",
      name: "Kostia",
      date_of_birth: "2005-08-26",
    })
  end

  def test_student_by_age 
    assert_equal [{
      surname: "Boiko",
      name: "Kostia",
      date_of_birth: "2005-08-26",
    }], Student.get_students_by_age(19)
  end

  def test_get_students_by_name
    assert_equal [{
      surname: "Izmalkova",
      name: "Sofia",
      date_of_birth: "2004-09-13",
    }], Student.get_students_by_name("Sofia")
  end

end
