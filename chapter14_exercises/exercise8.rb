filename = __FILE__
File.open(filename, "r") do |file|
  file.readlines.each do |line|
    puts line
  end
end
