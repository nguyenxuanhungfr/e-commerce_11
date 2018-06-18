class RatingsController < ApplicationController
  before_action :load_menu, :set_search_product
  before_action :params_rating_id, only: :update
  before_action :product_id_params

  def create
  	@rating = current_user.ratings.build params_rating

  	if @rating.save
  		respond_to do |format|
      format.js {render "rating.js.erb"}
      end
  	else
      flash[:danger] = t "error_inser_rating"
      redirect_to root_url
    end
  end

  def update
    if @rating.update_attributes params_rating
      respond_to do |format|
        format.js {render "rating.js.erb"}
      end
    else
      flash[:danger] = t "error_update_rating"
      redirect_to root_url
    end
  end

  private

  def params_rating
    params.require(:rating).permit :point, :product_id
  end

  def product_id_params
    @product = Product.find_by_id params[:rating][:product_id]
  end

  def params_rating_id
    @rating = current_user.ratings.find_by id: params[:id]
    unless @rating
      flash[:danger] = t "error.rating_not_found"
      redirect_to root_url
    end
  end
end
