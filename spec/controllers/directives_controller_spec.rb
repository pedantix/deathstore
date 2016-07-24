require 'rails_helper'

describe DirectivesController do
  let(:user) { create :user }
  let(:qr_svg_xml) do
    url = user_directives_url(user)
    qrcode = RQRCode::QRCode.new(url)

    qrcode.as_svg(offset: 0, color: '000', 
                    shape_rendering: 'crispEdges', 
                    module_size: 9)
  end

  context 'GET #qr_code' do 
    it 'should respond with svg xml' do
      get :qr_code, user_id: user.id

      expect(subject).to respond_with :ok
      expect(response.body).to eq qr_svg_xml
    end
  end  
end
