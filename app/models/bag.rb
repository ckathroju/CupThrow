class Bag < RandomizerCollection
  belongs_to :user

	# when store() invoked, Bag makes sure that randomizer r is reset
	def store(r)
		r.reset
		super
	end

	# when store() invoked, Bag makes sure that all randomizers added are reset
	def move_all(rc)
		super
		rc.reset
	end

	def select(description, amt=:all)
		#initialize return object
		hand = Hand.new

		# initialize local variables
		amt = self.count if (amt == :all)
		indices_to_delete = []

		# selects items from Bag based on the description
		self.items.each.with_index do |item, i|
			if description.all_match item
				indices_to_delete << i
				hand.store item
			end

			# up to the number entered into amount
			if indices_to_delete.length >= amt
				break
			end
		end

		# remove selected items from the bag
		remove_at indices_to_delete

		#  return the Hand object that is holding the selected items
		hand

	end

	private

	def remove_at(indices)
		indices.reverse.each do |del|			# reverses to delete from back to front, ow unstable
			self.items.delete_at del 				# delete.at is an array method
		end
    self.save
	end
end
