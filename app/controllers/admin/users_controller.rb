class Admin::UsersController < Admin::BaseController
  before_action :logged_in_user
  before_action :load_user, only: %i(show edit update destroy)

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).all.page(params[:page]).per Settings.settings.per_page
    if params[:q].present?
      flash.now[:success] = t "search_success"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "create_success"
      redirect_to admin_users_url
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "profile_updated"
      redirect_to admin_users_url
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "delete_success"
    redirect_to admin_users_url
  end

  private

  def user_params
    params[:user][:role] = params[:user][:role].to_i
    params.require(:user).permit :name, :email, :image, :password, :role, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "user_not_found"
    redirect_to admin_users_url
  end
end
