class WelcomeController < ApplicationController
  def index
    @user = User.find(current_user.id)
  end

  def about
  end
end
