module DepositsHelper
  def sorted_deposit_type
    DepositType.sorted 

  end
  def sorted_city
    City.sorted
  end
  # Devuelve una descripción del depósito que incluye Nombre, Tipo y Dirección.
  def deposit_label(dep)
    return unless dep
    "(#{dep.name}) - (#{dep.deposit_type.name}) - (#{dep.address})"
  end

  def checkForRepeatedValues(inventories)
    p inventories.inspect
    aux = inventories.first.product_id
    inventories.each do |i|
        if (i.product_id != aux)
        return false
        end
    end
    return true
  end

  module_function :deposit_label
end 