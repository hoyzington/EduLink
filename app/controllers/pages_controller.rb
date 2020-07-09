class PagesController < ApplicationController

  def home
    #byebug
    restore_admin
    redirect_to current_user if logged_in?
  end
  
end
