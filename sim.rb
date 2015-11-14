# Maybe simulate some tasks to do them from command line, b/c doing
# them in PacketTracer can be a hassle.

require 'yaml'
qs = YAML.load(File.read(File.join("questions", "questions.yml")))
qs.map! { |q| q["text"] = File.read(File.join("questions", q["file"])); q }

# Colorizing output for interest.
# http://stackoverflow.com/questions/1489183/colorized-ruby-output
class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end


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

# Apply some colors to a plain line.
def colorize_line(lin)
  case lin
  when /^Task:/
    return lin.blue.bold
  when /^Note:/
    return lin.italic.green
  when /^Complete:/
    return lin.green.bold
  else
    return lin
  end
end

q = qs[0]
puts q["question"]
lines = q["text"].split("\n")
lines.each do |lin|
  if lin.include?('#')
    test_input_line(lin)
  else
    puts colorize_line(lin)
  end
end
puts "DONE!"
