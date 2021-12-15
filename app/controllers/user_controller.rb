class UserController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def play_game
  end

  def purchase_items
  end
end
