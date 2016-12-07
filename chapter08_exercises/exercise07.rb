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
  if cohorts_list.include? cohort
    cohort
  else
    puts "Cohort not valid, must be equal to a month. Insert new cohort"
    cohort = gets.chomp
    cohort_validation(cohort)
  end
end

def insertion
  while true
    insertion = gets.chomp
    return student = [] if insertion.empty?
    student = insertion.split(",")
    student.delete_if {|x| x.strip == ""}
    student.map! {|x| x.strip}
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
  puts "Please enter the names and cohort (full month) of the students, comma separated. If no cohort is inserted a default value (#{default_cohort.to_s}) will be added"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name and cohort
  student = insertion
  # while the name is not empty, repeat this code
  while true
    # add the student hash to the array
    break if student.empty?
    students << {name: student[0], cohort: student[1].to_sym}
    p students
    puts "Now we have #{students.count} students"
    # get another name from the user
    student = insertion
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
  index = 0
  while true
    break if index == names.size
    puts "#{names[index][:name]}".ljust(20) + "#{names[index][:cohort]}".center(15)
    index += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
