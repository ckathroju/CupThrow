class Coin < Randomizer
  validate :validate_denomination
  enum result: [:H, :T].freeze

  before_create :reset

	def item
		:coin
	end

	def descriptor
		self.denomination
	end

	def randomize				# flips the coin and returns the number of flips performed (not the result)
    self.update(result: [:H, :T].sample, calls: calls + 1)
		self
	end

	def flip
		self.randomize
	end

	def sideup				# returns :H or :T (the result of the last flip) or nil (if no flips yet done)
		self.result
	end

	def up
		(self.result == :H) ? 1 : 0
	end

	private

  def validate_denomination
    errors.add(:denom, "supplied denomination #{self.denomination} is not one of { 0.1, 0.25, 0.05, 1, 2 }") unless valid_denomination(self.denomination)
  end

	def valid_denomination(denom)
		case denom
		when 1, 2, 0.05, 0.25, 0.1
			true
		else
			false
		end
	end
end
