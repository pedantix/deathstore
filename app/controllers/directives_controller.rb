class DirectivesController < ApplicationController
  helper_method :directive
  before_action :authenticate_user!, except: [:show, :qr_code]
  include ApplicationHelper

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

  def qr_code
    svg_file = Tempfile.new(["qr_code", ".svg"])
    svg_file.write qr_helper(user)
    send_file svg_file, type: "image/svg+xml",
                        x_sendfile: true
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
