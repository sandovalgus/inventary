class Inventory < ApplicationRecord
  belongs_to :product
  belongs_to :deposit
  belongs_to :provider
  has_many :move_details
  
  attr_accessor :product_quantity

  before_save :default_values

  extend Enumerize

  enumerize :status,  
              in: { disponible: 0, en_movimiento: 1, en_transito: 2, vendido: 3, eliminado: 4 }, 
              default: :disponible, 
              predicates: true
  # Status References
  # disponible    (success):  Producto disponible para manipulación (eliminar, mover, vender).
  # en_movimiento (warning):  Producto en carga como detalle de un movimiento entre depósitos.
  # eliminado     (danger):   Producto eliminado.   
  # en_transito   (info):     Producto en tránsito a depósito destino.
  # vendido       (danger):   Producto vendido.
  
  # Método que devuelve la cantidad de stock existente para un producto dentro del inventario, 
  # indistinto del depósito donde se encuentre.
  def stock_count(inv)
    count = Inventory.where(product_id: inv.product_id, product_exist: true).count
  end

  def default_values
    self.product_exist ||= true
    self.serial_number ||= 'empty'
    self.product_quantity ||= 1
  end

  def stock_count_per_deposit(inv)
    count = Inventory.where(product_id: inv.product_id, product_exist: true, deposit_id: inv.deposit_id).count
  end

  def update_status(inv, status)
    # Update status
    inv.update_attributes!(status: status)
  end

end
