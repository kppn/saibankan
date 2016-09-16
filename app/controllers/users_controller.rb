class UsersController < ApplicationController
  def home
    @projects = Project.all
    @mark = Mark.new
  end
end
