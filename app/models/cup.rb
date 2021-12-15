class Cup < RandomizerCollection
  belongs_to :user

	# each item in the cup is rolled or flipped,
	def throw
		self.items.each do |item|
			item.randomize
		end

		# all items are removed and stored in a Throw object, and returned
		Throw.new(self)
	end

	# enters each randomizer from a hand (synonym of move_all())
	def load(hand)
		self.move_all hand
	end
end
