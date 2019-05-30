# frozen_string_literal: true

# Clase para exportar Providers a archivos como Excel, ajustando los
# atributos y las relaciones has_many para acomodarlos en una sola fila.
#
class InventoryDepositExporter
    EXCEL_MIME_TYPE =
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  
    def initialize(inventories, deposit)
      @inventories = inventories
      @deposit = deposit
    end
   
    # Devuelve un arreglo con los nombres de los atributos para una fila de
    # encabezado.
    #

    def attributes
      attrs = %w[product_number product_name family producer producer_type category stock]
  
      attrs.map do |a|
        I18n.t(".activerecord.attributes.inventory.#{a}")
      end
    end
  
    # Devuelve un arreglo con los valores de los atributos en el mismo orden
    # que los encabezados en `attributes`. Convierte las relaciones many-to-many
    # a string concatenando los valores que correspondan.
    #
    def header
       [

        "Deposito: " +  @deposit.name,
        "Tipo de deposito: " + @deposit.deposit_type.name,
        "Ciudad: " + @deposit.city.name,
        "Provincia: " + @deposit.province.name,
        "País :" + @deposit.country.name
           
        ]

    end

    def values
      @inventories.map do  |inv, indexes|
        [
            inv.product_number,
            inv.name,
            inv.family.name,
            inv.producer.name,
            inv.product_type.name,
            inv.category.name,
            indexes.length
         ]  
      end
    end
  
    # Devuelve un arreglo con los formatos de datos para el archivo de Excel.
    # Tienen que tener el mismo orden que `attributes`. Si se coloca nil o se
    # omite el formato queda como string.
    #
    def formats
      [
        nil
      ]
    end
  
    def model_name 
      I18n.t('activerecord.models.inventory', count: 2)
    end
  
    def filename
      model_name.gsub(/\s/, '_').downcase
    end
  
    # Genera un archivo de Excel y devuelve un Stream para leerlo. No se guarda
    # en el sistema de archivos.
    #
      def to_excel_workbook
      p = Axlsx::Package.new
      wb = p.workbook
      styles = formats.map { |f| wb.styles.add_style(format_code: f) }
  
      wb.add_worksheet(name: model_name) do |sheet|
        sheet.add_row header, style: styles
        sheet.add_row
        
        sheet.add_row attributes
        
        values.each do |v|
          sheet.add_row v, style: styles
        end
  
        sheet.auto_filter = 'A1:B1'
      end
  
      p.to_stream
    end
  end
  