# frozen_string_literal: true

# Clase para exportar Providers a archivos como Excel, ajustando los
# atributos y las relaciones has_many para acomodarlos en una sola fila.
#
class InventoryExporter
    EXCEL_MIME_TYPE =
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  
    def initialize(inventories)
      @inventories = inventories
    end
   
    # Devuelve un arreglo con los nombres de los atributos para una fila de
    # encabezado.
    #

    def attributes
      attrs = %w[product_name stock deposit stock_deposit]
  
      attrs.map do |a|
        I18n.t(".activerecord.attributes.inventory.#{a}")
      end
    end
  
    # Devuelve un arreglo con los valores de los atributos en el mismo orden
    # que los encabezados en `attributes`. Convierte las relaciones many-to-many
    # a string concatenando los valores que correspondan.
    #
    def values
      @inventories.map do |inv|
        [
          inv.product.product_number + " - " + inv.product.name ,
          inv.stock_count(inv),
          inv.deposit.name,
          inv.stock_count_per_deposit(inv)
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
      
      @flag= ""
      wb.styles do |style|
          highlight_cell = style.add_style(bg_color: "e0e0e0")
          product_cell = style.add_style(bg_color: "b3e5fc")

        wb.add_worksheet(name: model_name) do |sheet|
          sheet.add_row attributes, style: highlight_cell
    
          values.each do |v|

            if @flag !="" && @flag == v[0]
              @flag =  v[0]
              v[0]= ""
              v[1]= ""
              sheet.add_row v, style: styles
            else
              @flag =  v[0]
              sheet.add_row v[0, 2], style: product_cell
              v[0]=""
              v[1]=""
              sheet.add_row v, style: styles
            end

          end
    
          sheet.auto_filter = 'A1:D1'
      end
    end

  
      p.to_stream
    end
  end
  