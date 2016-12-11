require 'csv'

@students = []

def interactive_menu
  loop do
    print_menu
    selection_process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def selection_process(selection)
  return input_students if selection == "1"
  return show_students  if selection == "2"
  return save_students  if selection == "3"
  return load_students(load_filename)  if selection == "4"
  exit if selection == "9"
  puts "I don't know what you mean, try again"
end

def get_student(name, cohort = :november)
  @students << {name: name, cohort: cohort}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    get_student(name)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
  feedback_message
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_filename # choose name for the filename
  puts "Insert the filename (no need for file extension)"
  filename = gets.chomp.delete(" ")
  filename = "#{filename}.csv"
  feedback_message_save_students(filename)
  filename
end

def save_students
  # open the file for writing
  CSV.open(save_filename, "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
end

def load_filename # choose filename to open
  puts "Insert the filename to be loaded (no need for file extension)"
  filename = STDIN.gets.chomp.delete(" ")
  filename = "#{filename}.csv"
end

def load_students(filename)
  CSV.foreach(filename) do |row|
    name, cohort = row[0], row[1]
    get_student(name, cohort.to_sym)
  end
  feedback_message
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil?  # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def feedback_message
  puts "Your operation was successefully executed!"
end

def feedback_message_save_students(filename)
  puts "The filanane #{filename} was successefully created!"
end

def print_header
  puts "The students of Villains Academy"
  puts "-----------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

try_load_students
interactive_menu
