class Hand < RandomizerCollection
	# removes and returns the last objected added
	# if no objects stored, return nil
	def next
	  res = self.items.pop
    self.save
    res
  end

	# removes all members of the collection (spilling them on the ground) and returns nil
	def empty
		self.update(items: [])
		nil
	end

	# removes all members of the collection and returns a new hand with the original values in it
	def empty_to_hand
		self
	end
end
