class PagesController < ApplicationController

  def home
    restore_admin
    redirect_to current_user if logged_in?
  end
  
end
