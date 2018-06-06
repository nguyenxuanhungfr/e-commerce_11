class StaticPagesController < ApplicationController
  before_action :load_menu, only: :home

  def home
    @products = Product.status_true.filter_by_less_price(params[:less_price]).filter_by_higher_price(params[:higher_price]).filter_by_category(params[:category_id]).search_by_name(params[:search]).order_product.limit Settings.settings.limit_product
  end
end
