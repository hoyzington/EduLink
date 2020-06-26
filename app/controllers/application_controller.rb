class ApplicationController < ActionController::Base

  before_action :set_object, only:[:show, :edit, :update, :destroy]

end
