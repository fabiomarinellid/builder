class Backoffice::DashboardController < ApplicationController

  layout "Backoffice"

  def index

    @adminsCount = User.where("id != ?", current_user.id)
  end
end
