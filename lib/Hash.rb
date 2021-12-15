#######################
# Adds the all_match meethod to the Hash class
#    - supports the description facility used by both Bag and Throw
#    - used in Bag when selecting items from the bag
#    - used in Throw when selecting items to tally, sum, etc.
class Hash
	def all_match(item)
		matches = true
		self.each do |key, value|
			matches &= (item.send(key) == value) 
		end
		matches
	end
end
