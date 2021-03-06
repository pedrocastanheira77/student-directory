def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  age = gets.chomp
  city_of_birth = gets.chomp
  # while the name is not empty, repeat this code
  while true
    # add the student hash to the array
    students << {name: name, cohort: :november, age: age, city_of_birth: city_of_birth}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
    break if name.empty?
    age = gets.chomp
    city_of_birth = gets.chomp
  end
  #return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-----------"
end

def print(names)
  index = 0
  while true
    break if index == names.size
    puts "#{names[index][:name]} #{names[index][:age]} #{names[index][:city_of_birth]} (#{names[index][:cohort]} cohort)"
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
