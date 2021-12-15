class RandomizerCollection < ApplicationRecord
  before_create :set_default_items
  serialize :items

  belongs_to :user

  def items_from_id
    Randomizer.where(id: self.items)
  end

  def count
		self.items.length
	end

	def store(r)
		raise ArgumentError, "argument #{r} is not a randomizer" unless r.is_a? Randomizer
		self.items << r.id
    self.save
		self
	end

	def store_all(randomizers)
		randomizers.each do |item|
			self.store item
		end
	end

	# gets each randomizer in rc & stores items in the new collection, emptying rc by the end
	def move_all(rc)
		self.store_hand rc.empty_to_hand
		self
	end

	def store_hand(items)
    items.each do |item|
			self.store(item)
    end
		self
	end

	# returns a Hand of all items in the collection and resets the collection (sets it to empty)
	def empty_to_hand
		hand = Hand.new
		items_from_id.each { |item| hand.store(item) }   # copies references of our items to hand
		reinitialize                              # eliminates reference to our former items in us
		hand
	end

	def empty
		self.empty_to_hand
	end

	def reset
		items_from_id.each { |item| item.reset }
		self
	end

	private

  def set_default_items
    self.items = [] if self.items.nil?
  end

	def reinitialize
		self.update(items: [])
	end
end
