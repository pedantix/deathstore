module ApplicationHelper
  def qr_helper
    url = user_directives_url(current_user)
    qrcode = RQRCode::QRCode.new(url)


    qrcode.as_svg(offset: 0, color: '000', 
                    shape_rendering: 'crispEdges', 
                    module_size: 9).html_safe
  end
end
