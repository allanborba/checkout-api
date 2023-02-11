class OrderCreator
  def perform(cpf, products, cupon_id = nil)
    validate_products(products)
    validate_cupon(cupon_id) if cupon_id
    order = Order.create(cpf: valid_cpf(cpf), discont_coupon_id: cupon_id, serial_number: serial_number)
    create_order_product_lists(products, order)
  end

  private

  def validate_products(products)
    validate_quantities(products.values)
    validate_product_existance(products.keys)
  end

  def validate_quantities(quantities)
    raise ArgumentError, "Quantity must be a Integer" if quantities.any? { |q| !q.is_a? Integer }
    raise ArgumentError, "Quantity must be greathr than one" if quantities.any? { |q| q < 1 }
  end

  def validate_product_existance(ids)
    raise ArgumentError, "Non-existent product id" if Product.where(id: ids).count != ids.count
  end

  def validate_cupon(cupon_id)
    raise ArgumentError, "Non-existent cupon id" if DiscontCoupon.where(id: cupon_id).blank?
  end

  def serial_number
    last_serial_number = Order.maximum(:serial_number)
    SerialNumberCreator.new(last_serial_number).perform
  end

  def valid_cpf(cpf)
    CpfSanatizerAndValidator.new(cpf).perform
  end

  def create_order_product_lists(products, order)
    products_list_attr = products.map do |id, quantity|
      OrderProductList.new(product_id: id, product_quantity: quantity, order_id: order.id)
    end
    OrderProductList.import(products_list_attr)
  end
end
