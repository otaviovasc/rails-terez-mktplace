class CartController < ApplicationController
  def show
    @render_cart = false
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)
    if current_orderable && quantity.positive?
      current_orderable.update(quantity:)
      redirect_to cart_path, notice: "O produto foi adicionado ao carrinho!"
    elsif quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(product: @product, quantity:)
    end
  end

  def checkout
    items = String.new
    @cart.orderables.each do |product|
      items << "%0A*#{product.quantity}*%20#{Product.find_by_id(product.product_id).name}%20R$#{Product.find_by_id(product.product_id).price}%0A"
    end
    redirect_to "https://api.whatsapp.com/send?phone=5518996469432&text=*Pedido%20numero%20via%20site*.%0A#{items}%0APre%C3%A7o%20total:%20R$:#{@cart.total}%20", allow_other_host: true, target: '_blank'
  end

  def remove
    Orderable.find_by(id: params[:id]).destroy
  end

  def clear
    Orderable.all.each do |product|
      product.destroy
    end
    redirect_to cart_path, notice: "Seu carrinho esta vazio!"
  end
end
