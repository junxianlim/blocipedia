# app/controllers/users_controllers.rb

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "Personal information updated"
      redirect_to_edit_user_registration_path(current_user)
    else
      render "devise/registrations/edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profilepic)
  end
end