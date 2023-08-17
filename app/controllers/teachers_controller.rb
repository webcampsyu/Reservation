class TeachersController < ApplicationController
  before_action :authenticate_teacher!
  
  def show
  end
end
