class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :bag
  has_one :cup

  after_commit :initialize_data, on: :create

         # returns the name of the player (does not set it)
	# stores the item in the player’s bag
	def store(item)
		bag.store item
	end

	# gets each item in supplied container and stores it in the player’s bag
	def move_all(container)
		bag.move_all container.empty_to_hand
	end

	# loads items from the player’s bag to the player’s cup based on the description
	def load(description, amt=:all)
		cup.load bag.select(description, amt)
	end

	# throws the cup, stores and returns the result
	def throw(the_throw = nil)
		the_throw = cup.throw      # throws the cup
		throws << the_throw        # stores the throw internally
		bag.move_all cup
		the_throw                   # returns the throw
	end

	# clears all stored throws
	def clear
		@throws = []
	end

	# calls tally(description) on each stored throw
	#    and returns the combined values as an array
	def tally(descr = {})
		throws.map { |a_throw| a_throw.description(descr).tally }
	end

	# calls sum(description) on each stored throw
	# and returns the combined values as an array
	def sum(descr = {})
		throws.map { |a_throw| a_throw.description(descr).sum }
	end

	# returns the report from the most recent throw
	def results(descr = {})
		throws.last.description(descr).results
	end

  def throws
    @throws ||= []
    @throws
  end

  def initialize_data
    items = []
    3.times {|_| items << Die.create(sides: 3).id}
    3.times {|_| items << Die.create(sides: 4).id}

    bag = Bag.create(user_id: self.id, items: items)

    Cup.create(user_id: self.id)
  end
end
