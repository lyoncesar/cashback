module Api
  class BaseController < ActionController::API
    include ActionController::MimeResponds

    before_action :http_basic_authenticate

    def http_basic_authenticate
      token = request.authorization.split(' ')
      decode = Base64.decode64(token[1]).split(':')

      user = decode[0]
      password = decode[1]

      unless user == 'lyoncesar' && password == 'password'
        render json: '', status: 403
      end
    end
  end
end
