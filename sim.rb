# Maybe simulate some tasks to do them from command line, b/c doing
# them in PacketTracer can be a hassle.

require 'yaml'
qs = YAML.load(File.read(File.join("questions", "questions.yml")))
qs.map! { |q| q["text"] = File.read(File.join("questions", q["file"])); q }

def test_input_line(lin)
  prompt, command = lin.strip.split("#")
  command.strip!
  attempt = 0
  c = ""
  while (attempt < 3 && c != command)
    print "#{prompt}\# "
    c = gets.strip
    attempt += 1
    if (c == "!quit") then
      puts "Quitting"
      exit 0
    end
    if (c != command) then
      puts " ... incorrect, please try again"
    end
  end
  if (attempt == 3 && c != command)
    puts "ANSWER: #{command}"
  end
end

q = qs[1]
puts q["question"]
lines = q["text"].split("\n")
lines.each do |lin|
  if lin.include?('#')
    test_input_line(lin)
  else
    puts lin
  end
end
puts "DONE!"
