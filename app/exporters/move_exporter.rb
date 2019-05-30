# frozen_string_literal: true

# Clase para exportar Providers a archivos como Excel, ajustando los
# atributos y las relaciones has_many para acomodarlos en una sola fila.
#
class MoveExporter
    EXCEL_MIME_TYPE =
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  
    def initialize(moves)
      @moves = moves
    end
    
    # Devuelve un arreglo con los nombres de los atributos para una fila de
    # encabezado.
    #

    def attributes
      attrs = %w[site_from site_to voucher_number move_date user_register user_take]
  
      attrs.map do |a|
        I18n.t(".activerecord.attributes.move.#{a}")
      end
    end
  
    # Devuelve un arreglo con los valores de los atributos en el mismo orden
    # que los encabezados en `attributes`. Convierte las relaciones many-to-many
    # a string concatenando los valores que correspondan.
    #
    def values

      @moves.map do |mv|

            [
                mv.move_details.last.site_from.name,
                mv.move_details.last.site_to.name,
                mv.voucher_number + " - " + mv.voucher_type.name,
                mv.move_date.to_date,
                mv.user_register.firstname + " " + mv.user_register.lastname,
                mv.user_take.firstname + " " + mv.user_take.lastname
            ]
      end
    end 
  
    # Devuelve un arreglo con los formatos de datos para el archivo de Excel.
    # Tienen que tener el mismo orden que `attributes`. Si se coloca nil o se
    # omite el formato queda como string.
    #
    def formats
      [
        nil,
        nil,
        nil,
        'DD/MM/YYYY',
        nil,
        nil
      ]
    end
  
    def model_name 
      I18n.t('activerecord.models.move', count: 2)
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
          sheet.add_row attributes
    
          values.each do |v|
            puts v
            sheet.add_row v, style: styles

          end
    
          sheet.auto_filter = 'A1:F1'
      end


  
      p.to_stream
    end
  end
  