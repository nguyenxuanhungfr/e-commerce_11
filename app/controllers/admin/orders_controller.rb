class Admin::OrdersController < Admin::BaseController
  before_action :logged_in_user
  before_action :load_order, except: %i(index new create)

  def index
    @orders = Order.filter_by_status(params[:status]).ordered.page(params[:page]).per Settings.settings.per_page
    if params[:status].present?
      flash.now[:success] = t "search_success"
    end
  end

  def show; end

  def edit
    @order = Order.find_by id: params[:id]
    @order_join = @order.order_details
  end

  def new; end

  def create; end

  def update
    if @order.update order_pamrams
      flash[:success] = t "update_success"
      redirect_to admin_orders_url
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t "delete_success"
    else
      flash[:errors] = t "delete_fail"
    end
    redirect_to admin_orders_url
  end

  private

  def load_order
      @order = Order.find_by id: params[:id]
      return if @order
      flash[:danger] = t "order_not_found"
      redirect_to admin_orders_url
  end

  def order_pamrams
    params[:order][:status] = params[:order][:status].to_i
    params.require(:order).permit :status
  end
end
