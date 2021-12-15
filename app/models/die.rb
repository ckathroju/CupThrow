class Die < Randomizer
  validate :validate_sides
  validate :validate_colour
  enum colour: [:white, :red, :green, :blue, :yellow, :black].freeze

  before_create :reset

	def item
		:die
	end

	def descriptor
		self.colour
	end

	def randomize				# flips the coin and returns the number of flips performed (not the result)
		self.update(result: rand(1..self.sides), calls: (self.calls || 0) + 1)
		self
	end

	def roll()			# randomizes and returns
		self.randomize
	end

	def sideup()
		self.result
	end

	def up
		self.result
	end

  private

  def validate_sides
    errors.add(:sides, "supplied side count #{self.sides} is not an integer greater than 1") unless valid_sides(self.sides)
  end

  def validate_colour
		errors.add(:colour, "supplied colour #{self.colour} is not one of { :white, :red, :green, :blue, :yellow, :black }") unless valid_colour(self.colour)
  end

	def valid_sides(sides)
		sides.is_a? Integer and sides > 1
	end

	def valid_colour(colour)
		case colour.to_sym
		when :white, :red, :green, :blue, :yellow, :black
			true
		else
			false
		end
	end
end
