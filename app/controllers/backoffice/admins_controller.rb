class Backoffice::AdminsController < ApplicationController

  before_action :set_admin, only: [:edit, :update, :destroy]

  layout "Backoffice"

  def index
    #Traz todo mundo menos o usuario corrente
    #@admins = User.all.where("id != ?", current_user.id).page(params[:page]).per(5)

    @admins = User.where("id != ? AND email LIKE ?", current_user.id, "%#{params[:q]}%").page(params[:page]).per(5)

    @adminsCount = User.where("id != ? AND email LIKE ?", current_user.id, "%#{params[:q]}%")
  end

  def new
    @admin = User.new
  end

  def create
    @admin = User.new(params_admin)
    if @admin.save
      redirect_to backoffice_admins_path
    else
      render :new
    end
  end

  def edit
    # Uses the before_action to set the admin.
  end

  def update
    if @admin.update(params_admin)
      redirect_to backoffice_admins_path
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to backoffice_admins_path
    else
      render :index
    end
  end

  private

    def set_admin
      @admin = User.find(params[:id])
    end

    def params_admin
        params.require(:user).permit(:email, :password, :password_confirmation)
    end


end
