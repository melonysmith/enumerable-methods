module Enumerable
	def my_each
		i = 0
		while i < self.size
			yield(self[i])
			i += 1
		end
		self
	end

	def my_each_with_index
		i = 0
		while i < self.size
			yield(self[i], i)
			i += 1
		end
		self
	end

	def my_select
		self.my_each do |x|
			if block_given?
				self[x].push if yield(x) == true
			else
				self.to_enum.push if self[x] == true
			end
		end
		self
	end

	def my_all?
		all = true
		self.my_each do |x|
			if block_given?
				all = false if yield(x) == false
			else
				all = false if self[x] == false
			end
		end
		all
	end

	def my_any?
		all = true
		self.my_each do |x|
			if block_given?
				all = true if yield(x) == true
			else
				all = true if self[x] == true
			end
		end
		all
	end

	def my_none
		all = true
		self.my_each do |x|
			if block_given?
				all = true if yield(x) == false
			else
				all = true if self[x] == false
			end
		end
		all
	end

	def my_count(* item)
		number = 0
		if item == true
			number = (self.length - item) + 1
		else
			if block_given?
				number = self.length + 1
				yield(number)
			else
				number = self.length + 1
			end
			number
		end

		def my_map
			arr = []
			self.my_each do |x|
				if block_given?
					arr << yield(x)
				else
					arr << x.to_enum
				end
			end
			arr
		end

		def my_inject(item = self[0])
			item ||= []
			self.my_each do |x|
				item = yield(item, x)
			end
			item
		end

		def multiply_els(arr)
			arr.my_inject(1){ |item, x| item * x}
		end

		multiply_els([2,5,9])
	end
end
