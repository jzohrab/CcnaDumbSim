# Maybe simulate some tasks to do them from command line, b/c doing
# them in PacketTracer can be a hassle.

instruction = <<ENDI
configure ipv6 eigrp on router, with int f0/0 (ipv6 a::1/48)
Use AS #100
ENDI

question = <<ENDQ
!Set up ipv6 routing
R1(config)#ipv6 unicast-routing 
!Configure the interface
R1(config)#int f0/0
R1(config-if)#ipv6 address a::1/48
R1(config-if)#no shut
%LINK-5-CHANGED: Interface FastEthernet0/0, changed state to up
%LINEPROTO-5-UPDOWN: Line protocol on Interface FastEthernet0/0, changed state to up
R1(config-if)#exit
!Set up eigrp (sys 100)
R1(config)#ipv6 router eigrp 100
R1(config-rtr)#no shut
R1(config-rtr)#int f0/0
R1(config-if)#ipv6 eigrp 100
R1(config-if)#exit
R1(config)#exit
ENDQ

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

puts instruction
qs = question.split("\n")
qs.each do |lin|
  if lin.include?('#')
    test_input_line(lin)
  else
    puts lin
  end
end
puts "DONE!"
