hh = {}

loop do

	print "Enter product id: "
	id = gets.chomp

	print "Enter amount (how much you want to order): "
	n = gets.chomp.to_i

	x = hh[id].to_i
	x += n
	hh[id] = x

	puts hh.inspect
	total = 0

	hh.each do |key,value|
		total = total + value
	end

	puts "Total add cart #{total}"

	puts "=========================="

end