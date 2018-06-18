class CategoriesController < ApplicationController
  before_action :load_menu, :load_category,:set_search_product, only: :show

  def show
    @products = @category.products.status_true.page(params[:page]).per Settings.settings.per_page
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t :not_found_cate
    redirect_to root_path
  end
end
