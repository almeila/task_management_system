class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  class Forbidden < ActionController::ActionControllerError; end
  class AdminRejected < ActionController::ActionControllerError; end

  rescue_from Exception, with: :rescue500
  rescue_from ApplicationController::Forbidden, with: :rescue403
  rescue_from ApplicationController::AdminRejected, with: :rescue403
  rescue_from ActionController::RoutingError, with: :rescue404
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404

  # TODO concernを使用するとHelperが参照できなくなる？　Couldn't find
  # include ErrorHandlers
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t('controller.application.please_login_message')
        redirect_to login_url
      end
    end

    def rescue403(e)
      @exception = e
      render 'errors/forbidden', status: 403 , layout: false
    end

    def rescue404(e)
      @exception = e
      render 'errors/not_found', status: 404 , layout: false
    end

    def rescue500(e)
      @exception = e
      render '/errors/internal_server_error', status: 500 , layout: false
    end
end