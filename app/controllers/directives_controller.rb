class DirectivesController < ApplicationController
  helper_method :directive
  before_action :authenticate_user!, except: :show

  def show
  end

  def new
  end

  def edit
  end

  def create
    user.create_directive!(directive_params)
    flash[:success] = t(".success")
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = t(".failure")
    render "new"
  end

  def update
    directive.update! directive_params
    flash[:success] = t(".success")
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = t(".failure")
    render "edit"
  end

  def destroy
    directive.destroy!
    flash[:success] = t(".success")
    redirect_to root_path
  end

  private

  def directive_params
    params.require(:directive).permit(:content)
  end

  def user
    @user ||= User.find params[:user_id]
  end

  def directive
    @directive ||= user.directive || user.build_directive
  end
end
