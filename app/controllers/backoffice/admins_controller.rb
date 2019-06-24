class Backoffice::AdminsController < ApplicationController

  before_action :set_admin, only: [:edit, :update, :destroy]

  layout "Backoffice"

  def index
    #Traz todo mundo menos o usuario corrente e os dados da pesquisa
    @admins = User.where("id != ? AND email LIKE ?", current_user.id, "%#{params[:q]}%").page(params[:page]).per(5)
    #Conta todo mundo menos o usuario corrente e os dados da pesquisa
    @adminsCount = User.where("id != ? AND email LIKE ?", current_user.id, "%#{params[:q]}%")
  end

  def new
    @admin = User.new
  end

  def create
    @admin = User.new(params_admin)
    if @admin.save
      redirect_to backoffice_admins_path,  notice: I18n.t('messages.created_with', item: @admin.email)
    else
      render :new
    end
  end

  def edit
    # Uses the before_action to set the admin.
  end

  def update
    if @admin.update(params_admin)
      redirect_to backoffice_admins_path, notice: I18n.t('messages.updated_with', item: @admin.email)
    else
      render :edit
    end
  end

  def destroy

    admin_email = @admin.email

    if @admin.destroy
      redirect_to backoffice_admins_path, notice: I18n.t('messages.destroyed_with', item: admin_email)
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
