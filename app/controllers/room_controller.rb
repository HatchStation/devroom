class RoomController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.only(:name, :online).all
  end
end
