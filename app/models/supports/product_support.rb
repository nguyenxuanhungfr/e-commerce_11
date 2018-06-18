class Supports::ProductSupport
  attr_reader :product

  def initialize product
    @product = product
  end

  def comments
    @comment ||= @product.comments
  end

  def images
    @images ||= @product.images
  end

  def new_ratting
    @rating ||= Rating.new
  end

  def product_slibar
    @product_new ||= Product.ordered.limit Settings.settings.limit_product_slibar
  end
end
