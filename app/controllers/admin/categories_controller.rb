class Admin::CategoriesController < Admin::BaseController
  before_action :logged_in_user, :load_status_category
  before_action :load_category, except: %i(index new create)

  def index
    @q = Category.ransack params[:q]
    @categories = @q.result(distinct: true).all.page(params[:page]).per Settings.settings.per_page
    if params[:q].present?
      flash.now[:success] = t "search_success"
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_pamrams

    if @category.save
      flash[:success] = t "create_success"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update_attributes category_pamrams
      flash[:success] = t "update_success"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy; end

  private

  def category_pamrams
    params[:category][:status] = params[:category][:status].to_i
    params.require(:category).permit :name, :status
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "category_not_found"
    redirect_to admin_categories_url
  end

  def load_status_category
    @category_status = Category.statuses.map { |value| value }
  end
end
