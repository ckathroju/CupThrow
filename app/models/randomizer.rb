class Randomizer < ApplicationRecord

	# abstract def item end
	def reset
		self.result = nil
    self.calls = 0
	end

	def randomize
		update(result: rand(), calls: self.calls + 1)
		self
	end

	def randomize_count
		self.calls
	end

	def item
		raise StandardError, "Call to abstract method: 'item' must be defined in and used by the subclass, not by the abstract super class Randomizer"
	end

	def descriptor
		raise StandardError, "Call to abstract method: 'descriptor' must be defined in and used by the subclass, not by the abstract super class Randomizer"
	end
end
