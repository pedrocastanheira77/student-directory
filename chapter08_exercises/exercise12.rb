def plural(amount)
  return "s" if amount > 1
  return "" if amount <= 1
end

def default_cohort
  "november"
end

def cohorts_list
  ["january",
   "february",
   "april",
   "march",
   "may",
   "june",
   "july",
   "august",
   "september",
   "october",
   "november",
   "december"
  ]
end

def cohort_validation(cohort)
  if cohorts_list.include? cohort.downcase
    cohort.downcase
  else
    puts "Cohort not valid, must be equal to a month. Insert new cohort"
    cohort = gets.strip
    cohort_validation(cohort)
  end
end

def student_insertion
  while true
    insertion = gets.strip
    return student = [] if insertion.empty?
    student = insertion.split(",")
    student.delete_if {|x| x.strip == ""}
    student.map! {|x| x.strip.downcase.capitalize}
    # if the user makes a typo, the cohort will be corrected
    student[1] = cohort_validation(student[1]) if student.size == 2
    # default cohort if no cohort is inserted
    student << default_cohort if student.size == 1
    break if (student.size == 2 && student[0] != "")
    puts "Name or cohort missing. Please type again, comma separated!"
  end
  student
end

def input_students
  puts "Please enter the names and cohort (full month name) of the students, comma separated. If no cohort is inserted a default value (#{default_cohort.to_s}) will be added"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name and cohort
  student = student_insertion
  # while the name is not empty, repeat this code
  while true
    # add the student hash to the array
    break if student.empty?
    students << {name: student[0], cohort: student[1].to_sym}
    puts "Now we have #{students.count} student" + plural(students.count)
    # get another name from the user
    student = student_insertion
  end
  #return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------------------------"
  puts "Name".ljust(20) + "Cohort".center(15)
end

def print(names)
    for month in 0...cohorts_list.size
      names.map do |x|
        puts "#{x[:name]}".ljust(20) + "#{x[:cohort]}".center(15) if x[:cohort] == cohorts_list[month].to_sym
      end
    end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great student" + plural(names.count)
end

students = input_students
if students.size > 1
  print_header
  print(students)
  print_footer(students)
else
  puts "No students inserted. The list is empty"
end
