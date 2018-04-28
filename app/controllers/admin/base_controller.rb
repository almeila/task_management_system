class Admin::BaseController < ApplicationController
  layout 'layouts/admin'
  before_action :admin_user

  private

    def admin_user
      if logged_in?
        unless current_user.admin_user?
          raise ApplicationController::AdminRejected
        end
      else
        store_location
        flash[:danger] = t('controller.application.please_login_message')
        redirect_to login_url
      end
    end

end
