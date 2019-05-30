module ProductsHelper
  def sorted_category 
    Category.sorted
  end

  def sorted_product_type
    ProductType.sorted
  end
  def sorted_family
    Family.sorted
  end

  def sorted_producer
    Producer.sorted
  end

  # Devuelve una descripción del producto que incluye Número de Producto, Nombre y Tipo.
  def product_label(prod)
    return unless prod
    "#{prod.product_number} - (#{prod.name}) - (#{prod.product_type.name})"
  end

  module_function :product_label
end