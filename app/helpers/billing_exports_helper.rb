module BillingExportsHelper
  def short_date(date_obj)
    I18n.l(date_obj, format: :short_date, default: '')
  end
end
