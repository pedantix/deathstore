module ApplicationHelper
  def qr_helper
    url = user_directives_url(current_user)
    qrcode = RQRCode::QRCode.new(url)


    qrcode.as_svg(offset: 0, color: '000', 
                    shape_rendering: 'crispEdges', 
                    module_size: 9).html_safe
  end

  MARKDOWN_RENDERER = Redcarpet::Markdown.
                                 new(Redcarpet::Render::HTML, autolink: true, tables: true)

  def markdown(text)
    MARKDOWN_RENDERER.render(text).html_safe
  end

  def home_page_markdown
    File.read("#{Rails.root}/README.md")
  end
end
